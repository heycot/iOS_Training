//
//  ViewListUserController.swift
//  iOS_Exercise
//
//  Created by Tu (Callie) T. NGUYEN on 1/4/19.
//  Copyright © 2019 Tu (Callie) T. NGUYEN. All rights reserved.
//

import UIKit

class ViewListUserController: UITableViewController{
    
    @IBOutlet weak var tableUserView: UITableView!
    
    var userBo = UserBO()
    var listUser = [User]()
    var userSelected = User()
    
    func prepareData() {
        listUser = userBo.getListUser()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listUser.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "User"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 117
       
        print("cell ", cell)
        let index = indexPath[1]
        cell.textLabel?.text = listUser[index].name
        cell.detailTextLabel?.text = listUser[index].born
//        cell.imageView?.image = UIImage(named: listUser[index].avatar)
        
        let containerView = UIView(frame: CGRect(x:0,y:0,width:50,height:60))
        let imageView = UIImageView()
        
        if let image = UIImage(named: listUser[index].avatar) {
            let ratio = image.size.width / image.size.height
            if containerView.frame.width > containerView.frame.height {
                let newHeight = containerView.frame.width / ratio
                imageView.frame.size = CGSize(width: containerView.frame.width, height: newHeight)
            }
            else{
                let newWidth = containerView.frame.height * ratio
                imageView.frame.size = CGSize(width: newWidth, height: containerView.frame.height)
            }
        }
        
        cell.imageView?.addSubview(imageView)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath[1]
        userSelected = listUser[index]
        
        self.performSegue(withIdentifier: "ShowDetailUserInList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ViewController
        {
            let vc = segue.destination as? ViewController
            vc?.user = userSelected
        }
    }
    
    
    override func viewDidLoad() {
         prepareData()
        super.viewDidLoad()
    }
}


