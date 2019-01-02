//
//  AddNewAccountController.swift
//  iOS_Exercise
//
//  Created by Tu (Callie) T. NGUYEN on 12/28/18.
//  Copyright © 2018 Tu (Callie) T. NGUYEN. All rights reserved.
//

import UIKit

class AddNewAccountController: UIViewController , UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var born: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var okBtn: UIButton!
    
    let datePicker = UIDatePicker()
    let genderPicker = UIPickerView()
    
    var userBo = UserBO()
    var newUser = User()
    var genderData: [String] = [String]()
    
    @IBAction func OKButtonClick(_ sender: UIButton) {
        newUser.avatar = ""
        newUser.name = name.text!
        newUser.born  = born.text!
        newUser.gender = gender.text!
        newUser.description = descriptionView.text!
        
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        showGenderPicker()
        descriptionView.delegate = self
        textFieldDidBeginEditing(textView: descriptionView)
    }
    
//
//    @objc func textViewdDidChange(_ textView: UITextView) {
//        if (textView.textColor == UIColor.lightGray) {
//            print("clear placeholder")
//            textView.text = ""
//            textView.textColor = UIColor.black
//        }
//    }
    
    
    func showDatePicker() {
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
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
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    func showGenderPicker() {
        
        genderData = ["Male", "Female"]
        // Connect data:
        genderPicker.delegate = self
        genderPicker.dataSource = self
        
        gender.inputView = genderPicker
    }
    
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
    
    func textFieldDidBeginEditing(textView: UITextView!) {    //delegate method
        
        if textView.text.isEmpty {
            print("print placeholder")
            textView.text = "Enter description"
            textView.textColor = UIColor.lightGray
        }
    }
    
    
    
    func textFieldShouldEndEditing(textField: UITextField!) -> Bool {  //delegate method
        return false
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        
        return true
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        if (textView.textColor == UIColor.lightGray) {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
}

