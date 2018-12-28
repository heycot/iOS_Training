//
//  ViewController.swift
//  iOS_Exercise
//
//  Created by Tu (Callie) T. NGUYEN on 12/25/18.
//  Copyright © 2018 Tu (Callie) T. NGUYEN. All rights reserved.
//

import UIKit
//import <UITextView+Placeholder/UITextView+Placeholder.h>

class ViewController: UIViewController {
    
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var NameView: UITextField!
    @IBOutlet weak var BornView: UITextField!
    @IBOutlet weak var GenderView: UITextField!
    @IBOutlet weak var DescriptionView: UITextView!
    
    var userBo = UserBO()
    let noAvatar = "no_avatar"
    var user = User()
    
    func prepareShowDetailAccount() {
        NameView.text = ""
        BornView.text = ""
        GenderView.text = ""
        DescriptionView.text = ""
    }
    
    func showDefaultAccount() {
        var userDefault = userBo.getUserDefault()
        var image : UIImage = UIImage(named: userDefault.avatar)!
        avatarView? = UIImageView(image: image)
        
        NameView?.text = userDefault.name
        BornView?.text = userDefault.born
        GenderView?.text = userDefault.gender
        DescriptionView?.text = userDefault.description
    }
    
    func showDetailAccount(user:User) {
        print("show user:" + user.name)
        var image : UIImage = UIImage(named: user.avatar)!
        avatarView? = UIImageView(image: image)
        
        NameView?.text = user.name
        BornView?.text = user.born
        GenderView?.text = user.gender
        DescriptionView?.text = user.description
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (user.name != "") {
            showDetailAccount(user: user)
        } else {

            user = userBo.getUserDefault()
            print("user:" + user.name)
//            showDefaultAccount()
            showDetailAccount(user: user)
        }
        
        
    }
    
    
}

