//
//  AddNewAccountController.swift
//  iOS_Exercise
//
//  Created by Tu (Callie) T. NGUYEN on 12/28/18.
//  Copyright © 2018 Tu (Callie) T. NGUYEN. All rights reserved.
//

import UIKit
import Darwin

class AddNewAccountController: UIViewController, ViewControllerDelegate{
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var born: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    
    @IBOutlet weak var doneBtn: UIBarButtonItem!
    
    let datePicker = UIDatePicker()
    let genderPicker = UIPickerView()
    
    var userBo = UserBO()
    var newUser = User()
    let noAvatar = "no_avatar"
    var genderData: [String] = [String]()
    
    @IBAction func cancelBtnClick(_ sender: UIBarButtonItem) {
        exit(0)
    }
    
//    @IBAction func doneBtnClick(_ sender: Any?) {
//        if ( name.text! == "" || born.text! == "" || gender.text! == "" || descriptionView.text! == "") {
//            let alertController = UIAlertController(title: "Can not add!", message: "All information is required!", preferredStyle: UIAlertController.Style.alert)
//            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//            present(alertController, animated: true, completion: nil)
//        } else {
//            newUser.avatar = noAvatar
//            newUser.name = name.text!
//            newUser.born  = born.text!
//
//            for i in 0..<genderData.count {
//                if (genderData[i] == gender.text!){
//                    newUser.gender = Int64(i)
//                }
//            }
//            newUser.description = descriptionView.text!
//
//            if ( userBo.addOneUser(user: newUser) == true ) {
//                print("add new user success!")
//                self.performSegue(withIdentifier: "ShowDetailUser", sender: self)
//            } else {
//                let alertController = UIAlertController(title: "Something went wrong!", message: "Try it later!", preferredStyle: UIAlertController.Style.alert)
//                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//                present(alertController, animated: true, completion: nil)
//            }
//        }
//    }
    
    func addNewAccount(controller: ViewController){
        if ( name.text! == "" || born.text! == "" || gender.text! == "" || descriptionView.text! == "") {
            let alertController = UIAlertController(title: "Can not add!", message: "All information is required!", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        } else {
            newUser.avatar = noAvatar
            newUser.name = name.text!
            newUser.born  = born.text!
            
            for i in 0..<genderData.count {
                if (genderData[i] == gender.text!){
                    newUser.gender = Int64(i)
                }
            }
            newUser.description = descriptionView.text!
            
            if ( userBo.addOneUser(user: newUser) == true ) {
                print("add new user success!")
//                self.performSegue(withIdentifier: "ShowDetailUser", sender: self)
                controller.navigationController?.popViewController(animated: true)
            } else {
                let alertController = UIAlertController(title: "Something went wrong!", message: "Try it later!", preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navVC = segue.destination as? UINavigationController
        
        if navVC?.viewControllers.first is ViewController {
            let vc = navVC?.viewControllers.first as? ViewController
            vc?.user = newUser
            vc?.delegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        showGenderPicker()
        descriptionView.delegate = self
        born.delegate = self
        gender.delegate = self
        textViewDidBeginEditing(descriptionView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        name.resignFirstResponder()
        descriptionView.resignFirstResponder()
    }
    
    func showDatePicker() {
        //Formate Date
        datePicker.datePickerMode = .date
        
        var components = DateComponents()
        components.year = -100
        let minDate = Calendar.current.date(byAdding: components, to: Date())
        
        components.year = -18
        let maxDate = Calendar.current.date(byAdding: components, to: Date())
        
        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        // add toolbar to textField
        born.inputAccessoryView = toolbar
        // add datepicker to textField
        born.inputView = datePicker

    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        born.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelPicker(){
        self.view.endEditing(true)
    }
    
    func showGenderPicker() {
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneGenderPicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        // add toolbar to textField
        gender.inputAccessoryView = toolbar
        
        
        genderData = ["Male", "Female"]
        // Connect data:
        genderPicker.delegate = self
        genderPicker.dataSource = self
        
        gender.inputView = genderPicker
    }
    
    @objc func doneGenderPicker(){
        let row = genderPicker.selectedRow(inComponent: 0)
        gender.text = genderData[row]
        self.view.endEditing(true)
    }
    
    
    func validGenderInput(text: String) -> String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ")
        return text.filter {okayChars.contains($0) }
    }
    
    func validBornInput(text: String) -> String {
        let okayChars = Set("0123456789/")
        return text.filter {okayChars.contains($0) }
    }

    
}

extension AddNewAccountController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if  textField == born {
            born.text = validBornInput(text: textField.text!)
            
            return string.rangeOfCharacter(from: CharacterSet.letters) == nil
            
        } else if textField == gender {
            gender.text = validGenderInput(text: textField.text!)
            return string.rangeOfCharacter(from: CharacterSet.decimalDigits) == nil
        }
        
        return true
    }
}


extension AddNewAccountController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter description"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if (textView.textColor == UIColor.lightGray) {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
}

extension AddNewAccountController: UIPickerViewDelegate, UIPickerViewDataSource {
       
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gender.text = genderData[row]
    }
}

