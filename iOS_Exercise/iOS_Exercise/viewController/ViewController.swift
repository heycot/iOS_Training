//
//  ViewController.swift
//  iOS_Exercise
//
//  Created by Tu (Callie) T. NGUYEN on 12/25/18.
//  Copyright © 2018 Tu (Callie) T. NGUYEN. All rights reserved.
//

import UIKit

class ViewController:  UIViewController{
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var born: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var follower: UITextField!
    @IBOutlet weak var update: UITextField!
    @IBOutlet weak var following: UITextField!
    @IBOutlet weak var generalStackView: UIStackView!
    
    @IBOutlet weak var firstFriendImage: UIImageView!
    @IBOutlet weak var secondFriendImage: UIImageView!
    @IBOutlet weak var thirdFriendImage: UIImageView!
    
    var userBo = UserBO()
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareShowDetailAccount()
        reloadData()
        
        if (user.name == "") {
            user = userBo.getUserDefault()
        }
        showDetailAccount(user: user)
        disabledView()
        addBackgroundStackView()
    }
    
    func prepareShowDetailAccount() {
        name.text = ""
        born.text = ""
        descriptionView.text = ""
    }
    
    public func reloadData() {
        user = userBo.findOneById(rowId: user.id)
    }
    
    func showDetailAccount(user:User) {
        self.title = user.name
        
        avatar.image = Config.getImage(nameImage: user.avatar)
        avatar.setRounded(color: UIColor.white)
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.clickAvatar))
        avatar.isUserInteractionEnabled = true
        avatar.addGestureRecognizer(singleTap)
        
        name?.text = user.name
        descriptionView?.text = user.description
        
        if (user.gender == 0) {
            born?.text = user.born + " | Male"
        } else {
            born?.text = user.born + " | Female"
        }
        
        following.text = "500"
        follower.text = "200K"
        update.text = "15K"
        
        showFriends()
    }
    
    func disabledView() {
        name.isEnabled = false
        born.isEnabled = false
        descriptionView.isEditable = false
        
        follower.isEnabled = false
        following.isEnabled = false
        update.isEnabled = false
    }
    
    func addBackgroundStackView() {
        generalStackView.addBackground(color: UIColor(red: CGFloat(238.0/255.0), green: CGFloat(238.0/255.0), blue: CGFloat(238.0/255.0), alpha: CGFloat(1.0)))
    }
    
    func showFriends() {
        let users = userBo.getListUser()
        var friends: [User] = []
        for friend in users {
            if (friend.id != user.id){
                friends.append(friend)
            }
        }
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.clickAvatarFriends))
        firstFriendImage.image = Config.getImage(nameImage: friends[0].avatar)
        firstFriendImage.setRounded(color: UIColor.white)
        firstFriendImage.isUserInteractionEnabled = true
        firstFriendImage.addGestureRecognizer(singleTap)
        
        secondFriendImage.image = Config.getImage(nameImage: friends[1].avatar)
        secondFriendImage.setRounded(color: UIColor.white)
        secondFriendImage.isUserInteractionEnabled = true
        secondFriendImage.addGestureRecognizer(singleTap)
        
        thirdFriendImage.image = Config.getImage(nameImage: friends[2].avatar)
        thirdFriendImage.setRounded(color: UIColor.white)
        thirdFriendImage.isUserInteractionEnabled = true
        thirdFriendImage.addGestureRecognizer(singleTap)
    }
    
    //Action
    @objc func clickAvatar() {
        print("Imageview Clicked")
        performSegue(withIdentifier: "showHandleAvatar", sender: nil)
    }
    
    @objc func clickAvatarFriends() {
        print("Imageview Clicked")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is HandleAvatarViewController
        {
            let vc = segue.destination as? HandleAvatarViewController
            vc?.user = user
            vc?.instanceOfVC = self
        }
    }
    
    @IBAction func backBtnClick(_ sender: Any) {
//        self.navigationController?.popToRootViewController(animated: true)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewListUserControllerID")
        self.navigationController?.pushViewController(vc!, animated: false)
    }
}



