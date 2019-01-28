//
//  HandleAvatarViewController.swift
//  iOS_Exercise
//
//  Created by Tu (Callie) T. NGUYEN on 1/28/19.
//  Copyright © 2019 Tu (Callie) T. NGUYEN. All rights reserved.
//

import UIKit

class HandleAvatarViewController: UIViewController{

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var handleAvatarTableView: UITableView!
    
    var handles: [String] = ["Show photo", "Change photo", "Delete photo"]
    var user = User()
    var userBo = UserBO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func close(_ sender: Any) {
        dismisHandle()
    }
    
    func dismisHandle() {
        dismiss(animated: true, completion: nil)
    }
    
    func deleteAvatar() {
        
        let removeImageAlert = UIAlertController(title: "Delete", message: "Delete your photo.", preferredStyle: UIAlertController.Style.alert)
        
        removeImageAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            if (self.userBo.deleteAvatar(rowId: self.user.id) == true ) {
                self.dismisHandle()
            }
        }))
        
        removeImageAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(removeImageAlert, animated: true, completion: nil)
    }
    
    func changeAvatar() {
        
    }
    
    func showAvatar() {
        let imageView = UIImage(named: user.avatar)
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
    
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
        
}

extension HandleAvatarViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let cell = tableView.cellForRow(at: indexPath)
        handleAvatarTableView.deselectRow(at: indexPath, animated: true)
    
        if (indexPath.row == 0) {
            showAvatar()
//            addImageViewWithImage()
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
        return handles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = handles[indexPath.row]
        cell?.textLabel?.textColor = UIColor(red: CGFloat(0.0/255.0), green: CGFloat(150.0/255.0), blue: CGFloat(255.0/255.0), alpha: CGFloat(1.0))
        
        return cell!
    }
    
}
