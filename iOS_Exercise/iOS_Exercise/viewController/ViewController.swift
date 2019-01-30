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
    @IBOutlet weak var friendsLable: UILabel!
    
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
        setTapForFriendsImage(userSender: friends[0], itemImage: firstFriendImage)
        setTapForFriendsImage(userSender: friends[1], itemImage: secondFriendImage)
        setTapForFriendsImage(userSender: friends[2], itemImage: thirdFriendImage)
        
        setLongTapFriendsImage(userSender: friends[0], itemImage: firstFriendImage)
        setLongTapFriendsImage(userSender: friends[1], itemImage: secondFriendImage)
        setLongTapFriendsImage(userSender: friends[2], itemImage: thirdFriendImage)
    }
    
    func setLongTapFriendsImage(userSender: User, itemImage: UIImageView) {
        let firstLongTap = MyLongTapGesture(target: self, action: #selector(self.longTapAvatarFriends))
        firstLongTap.minimumPressDuration = 1
        itemImage.setRounded(color: UIColor.white)
        itemImage.isUserInteractionEnabled = true
        itemImage.addGestureRecognizer(firstLongTap)
        firstLongTap.title = userSender.name
    }
    
    func setTapForFriendsImage(userSender: User, itemImage: UIImageView) {
        let singleTap = MyTapGesture(target: self, action: #selector(self.clickAvatarFriends))
        
        itemImage.image = Config.getImage(nameImage: userSender.avatar)
        itemImage.setRounded(color: UIColor.white)
        itemImage.isUserInteractionEnabled = true
        itemImage.addGestureRecognizer(singleTap)
        singleTap.userSender = userSender
    }
    
    //Action
    @objc func clickAvatar() {
        performSegue(withIdentifier: "showHandleAvatar", sender: nil)
    }
    
    @objc func clickAvatarFriends(sender : MyTapGesture) {
        self.user = sender.userSender
        self.showDetailAccount(user: sender.userSender)
    }
    
    @objc func longTapAvatarFriends(sender : MyLongTapGesture) {
         friendsLable.text = sender.title
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



