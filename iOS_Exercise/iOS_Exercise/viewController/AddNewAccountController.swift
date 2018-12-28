//
//  AddNewAccountController.swift
//  iOS_Exercise
//
//  Created by Tu (Callie) T. NGUYEN on 12/28/18.
//  Copyright © 2018 Tu (Callie) T. NGUYEN. All rights reserved.
//

import UIKit

class AddNewAccountController: UIViewController {
    
    @IBOutlet weak var NameAddNewAccount: UITextField!
    @IBOutlet weak var BornAddNewAccount: UITextField!
    @IBOutlet weak var GenderAddNewAccount: UITextField!
    @IBOutlet weak var DescriptionAddNewAccount: UITextView!
    @IBOutlet weak var OKBtnAddNewAccount: UIButton!
    
    var userBo = UserBO()
    var newUser = User()
    
    @IBAction func OKButtonClick(_ sender: UIButton) {
        newUser.avatar = ""
        newUser.name = NameAddNewAccount.text!
        newUser.born  = BornAddNewAccount.text!
        newUser.gender = GenderAddNewAccount.text!
        newUser.description = DescriptionAddNewAccount.text!
        
        
        if ( newUser.name == "" || newUser.born == "" || newUser.gender == "" || newUser.description == "") {
            let alertController = UIAlertController(title: "Can not add!", message: "All information is required!", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        } else {
            if ( userBo.addOneUser(user: newUser) == true ) {
                
                self.performSegue(withIdentifier: "ShowDetailUser", sender: self)
            } else {
                let alertController = UIAlertController(title: "Something went wrong!", message: "Try it later!", preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ViewController
        {
            let vc = segue.destination as? ViewController
            vc?.user = newUser
        }
    }
    
    func textViewdDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
        else if textView.text.isEmpty {
            textView.text = "Enter description"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter description "
            textView.textColor = UIColor.lightGray
        } else {
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textViewdDidBeginEditing(DescriptionAddNewAccount)
        textViewDidEndEditing(DescriptionAddNewAccount)
    }
    
    
}

