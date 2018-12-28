//
//  AddNewAccountController.swift
//  iOS_Exercise
//
//  Created by Tu (Callie) T. NGUYEN on 12/28/18.
//  Copyright © 2018 Tu (Callie) T. NGUYEN. All rights reserved.
//

import UIKit

class AddNewAccountController: UIViewController {
    
    //UI add new account
    @IBOutlet weak var NameAddNewAccount: UITextField!
    @IBOutlet weak var BornAddNewAccount: UITextField!
    @IBOutlet weak var GenderAddNewAccount: UITextField!
    @IBOutlet weak var DescriptionAddNewAccount: UITextView!
    @IBOutlet weak var OKBtnAddNewAccount: UIButton!
    
    var userBo = UserBO()
    let noAvatar = "no_avatar"
    var newUser = User()
    
    @IBAction func OkButtonPress(_ sender: UIButton) {
        var name = NameAddNewAccount?.text
        var born  = BornAddNewAccount?.text
        var gender = GenderAddNewAccount?.text
        var description = DescriptionAddNewAccount?.text
        
        if ( name == "" || born == "" || gender == "" || description == "") {
            let alertController = UIAlertController(title: "Can not add!", message: "All information is required!", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        } else {
            
            newUser = User(name: name!, born: born!, gender: gender!, avatar: noAvatar, description: description!)
            if ( userBo.addOneUser(user: newUser) == true ) {
                self.performSegue(withIdentifier: "ShowDetailUser", sender: self)
            } else {
                let alertController = UIAlertController(title: "Something went wrong!", message: "Try it later!", preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        print("+++ show detail user")
        if segue.destination is ViewController
        {
            print("---> show detail user")
            let vc = segue.destination as? ViewController
            vc?.user = newUser
        }
    }
    
    
    func showDetailScreen(user:User) {
        
        let vc = ViewController(nibName: "ViewController", bundle: nil)
        vc.user = user
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func textViewdDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
        else if textView.text.isEmpty {
            print("add placeholder")
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
    
    func textViewClicked(_ textView: UITextView?) {
        textView?.text = ""
        textView?.textColor = UIColor.black
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

