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
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    
    var userBo = UserBO()
    var user = User()
    
    func prepareShowDetailAccount() {
        name.text = ""
        born.text = ""
        gender.text = ""
        descriptionView.text = ""
    }
    
    
    func showDetailAccount(user:User) {
//        let image : UIImage = UIImage(named: user.avatar)!
//        avatar? = UIImageView(image: image)
        avatar.image = UIImage(named: user.avatar)
        
        
        name?.text = user.name
        born?.text = user.born
        descriptionView?.text = user.description
        
        if (user.gender == 0) {
            gender?.text = "Male"
        } else {
            gender?.text = "Female"
        }
    }
    
    func disabledView() {
        name.isEnabled = false
        born.isEnabled = false
        gender.isEnabled = false
        descriptionView.isEditable = false
    }
    
    @IBAction func doneBtnClick(_ sender: Any) {
//        self.navigationController?.popToRootViewController(animated: true)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewListUserControllerID")
        self.navigationController?.pushViewController(vc!, animated: false)
     }
    
    @IBAction func cancelBtnClick(_ sender: Any) {
        exit(0)
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
    }
}

