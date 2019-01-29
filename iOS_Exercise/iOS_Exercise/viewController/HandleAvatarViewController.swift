//
//  HandleAvatarViewController.swift
//  iOS_Exercise
//
//  Created by Tu (Callie) T. NGUYEN on 1/28/19.
//  Copyright © 2019 Tu (Callie) T. NGUYEN. All rights reserved.
//

import UIKit
import Photos

class HandleAvatarViewController: UIViewController{

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var handleAvatarTableView: UITableView!
    
    var user = User()
    var userBo = UserBO()
    var instanceOfVC:ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpForTableView()
    }
    
    func setUpForTableView() {
        handleAvatarTableView.delegate = self
        handleAvatarTableView.dataSource = self
        
        handleAvatarTableView.estimatedRowHeight = UITableView.automaticDimension
        handleAvatarTableView.rowHeight = 50
        
        setCornerRadius()
    }
    
    func setCornerRadius() {
        cancelBtn.layer.cornerRadius = 10
        handleAvatarTableView.layer.cornerRadius = 10
    }
    
    func showAvatar() {
        let imageView = Config.getImage(nameImage: user.avatar)
        let newImageView = UIImageView(image: imageView)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
        
    func changeAvatar() {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType =  UIImagePickerController.SourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    func deleteAvatar() {
        
        let removeImageAlert = UIAlertController(title: "Delete", message: "Delete your photo.", preferredStyle: UIAlertController.Style.alert)
        
        removeImageAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            if (self.userBo.changeAvatar(rowId: self.user.id, avatar: Config.NO_AVATAR) == true ) {
                self.dismisHandle()
                self.instanceOfVC.viewDidLoad()
            }
        }))
        
        removeImageAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(removeImageAlert, animated: true, completion: nil)
    }
    
    func saveImageDocumentDirectory(){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("apple.jpg")
        let image = UIImage(named: "apple.jpg")
        print(paths)
//        let imageData = UIImageJPEGRepresentation(image!, 0.5)
        let imageData = image!.jpegData(compressionQuality: 0.75)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
    
    func generateNameForImage() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "IMG_hh.mm.ss.dd.MM.yyyy"
        return formatter.string(from: date)
    }
    
    func dismisHandle() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    @IBAction func close(_ sender: Any) {
        dismisHandle()
    }
}

extension HandleAvatarViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        var fileName = ""
        
        if let url = info[UIImagePickerController.InfoKey.referenceURL] as? URL {
            let assets = PHAsset.fetchAssets(withALAssetURLs: [url], options: nil)
            if let firstAsset = assets.firstObject,
                let firstResource = PHAssetResource.assetResources(for: firstAsset).first {
                fileName = firstResource.originalFilename
            } else {
                fileName = generateNameForImage()
            }
        } else {
            fileName = generateNameForImage()
        }
        
        if (fileName != "") {
            let fileManager = FileManager.default
            let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(fileName)
            print(paths)
            let imageData = selectedImage.jpegData(compressionQuality: 0.75)
            fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
            
            if (self.userBo.changeAvatar(rowId: self.user.id, avatar: fileName) == true ) {
                self.dismisHandle()
                self.instanceOfVC.viewDidLoad()
            }
        }
    }
}

extension HandleAvatarViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let cell = tableView.cellForRow(at: indexPath)
        handleAvatarTableView.deselectRow(at: indexPath, animated: true)
    
        if (indexPath.row == 0) {
            showAvatar()
        } else if (indexPath.row == 1) {
            changeAvatar()
        } else {
            deleteAvatar()
        }
        
    }
}

extension HandleAvatarViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Config.HANDLE_AVATAR.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = Config.HANDLE_AVATAR[indexPath.row]
        cell?.textLabel?.textColor = UIColor(red: CGFloat(0.0/255.0), green: CGFloat(150.0/255.0), blue: CGFloat(255.0/255.0), alpha: CGFloat(1.0))
        
        return cell!
    }
    
}
