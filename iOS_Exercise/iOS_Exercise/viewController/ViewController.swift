//
//  ViewController.swift
//  iOS_Exercise
//
//  Created by Tu (Callie) T. NGUYEN on 12/25/18.
//  Copyright © 2018 Tu (Callie) T. NGUYEN. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var born: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var follower: UITextField!
    @IBOutlet weak var update: UITextField!
    @IBOutlet weak var following: UITextField!
    
    @IBOutlet weak var generalStackView: UIStackView!
    var userBo = UserBO()
    var user = User()
    
    func prepareShowDetailAccount() {
        name.text = ""
        born.text = ""
        descriptionView.text = ""
        
        
    }
    
    func showDetailAccount(user:User) {
//        let image : UIImage = UIImage(named: user.avatar)!
//        avatar? = UIImageView(image: image)
        avatar.image = UIImage(named: user.avatar)
        avatar.setRounded(color: UIColor.white)
        
        name?.text = user.name
//        born?.text = user.born + " | Male"
        descriptionView?.text = user.description
        
        if (user.gender == 0) {
            
            born?.text = user.born + " | Male"
        } else {
            
            born?.text = user.born + " | Female"
        }
        
        following.text = "500"
        follower.text = "200K"
        update.text = "15K"
        
    }
    
    func disabledView() {
        name.isEnabled = false
        born.isEnabled = false
        descriptionView.isEditable = false
        
        follower.isEnabled = false
        following.isEnabled = false
        update.isEnabled = false
    }
    
    @IBAction func backBtnClick(_ sender: Any) {
//        self.navigationController?.popToRootViewController(animated: true)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewListUserControllerID")
        self.navigationController?.pushViewController(vc!, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareShowDetailAccount()
        
        if (user.name != "") {
            showDetailAccount(user: user)
        } else {
            user = userBo.getUserDefault()
            showDetailAccount(user: user)
        }
        
        self.title = user.name
        disabledView()
        
        generalStackView.addBackground(color: UIColor(red: CGFloat(238.0/255.0), green: CGFloat(238.0/255.0), blue: CGFloat(238.0/255.0), alpha: CGFloat(1.0)))
    }
}


extension UIStackView {
    
    func addBackground(color: UIColor) {
        let subview = UIView(frame: bounds)
        subview.backgroundColor = color
        subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subview, at: 0)
    }
    
}

