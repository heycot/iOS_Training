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
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var born: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    
    var userBo = UserBO()
    let noAvatar = "no_avatar"
    var user = User()
    
    func prepareShowDetailAccount() {
        name.text = ""
        born.text = ""
        gender.text = ""
        descriptionView.text = ""
    }
    
    func showDetailAccount(user:User) {
        var image : UIImage = UIImage(named: user.avatar)!
        avatar? = UIImageView(image: image)
        
        name?.text = user.name
        born?.text = user.born
        gender?.text = user.gender
        descriptionView?.text = user.description
    }
    
    func disabledView() {
        name.isEnabled = false
        born.isEnabled = false
        gender.isEnabled = false
        descriptionView.isEditable = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareShowDetailAccount()
        
        if (user.name != "") {
            user.avatar = noAvatar
            showDetailAccount(user: user)
        } else {
            user = userBo.getUserDefault()
            showDetailAccount(user: user)
        }
        disabledView()
    }
}

