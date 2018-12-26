//
//  ViewController.swift
//  iOS_Exercise
//
//  Created by Tu (Callie) T. NGUYEN on 12/25/18.
//  Copyright © 2018 Tu (Callie) T. NGUYEN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var BornTextField: UITextField!
    @IBOutlet weak var GenderTextField: UITextField!
    @IBOutlet weak var DescriptionTextView: UITextView!
    
    var userBo = UserBO()
    
    func prepareShow() {
        NameTextField.text = ""
        BornTextField.text = ""
        GenderTextField.text = ""
        DescriptionTextView.text = ""
    }
    
    func showDefaultUser() {
        var userDefault = userBo.getUserDefault()
        var image : UIImage = UIImage(named: userDefault.avatar)!
        avatarImageView = UIImageView(image: image)
        
        NameTextField.text = userDefault.name
        BornTextField.text = userDefault.born
        if (userDefault.gender == 1) {
            GenderTextField.text = "Female"
        } else {
            GenderTextField.text = "Male"
        }
        DescriptionTextView.text = userDefault.description
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        prepareShow()
        showDefaultUser()
    }
    
    
}

