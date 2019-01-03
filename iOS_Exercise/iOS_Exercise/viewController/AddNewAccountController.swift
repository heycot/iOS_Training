//
//  AddNewAccountController.swift
//  iOS_Exercise
//
//  Created by Tu (Callie) T. NGUYEN on 12/28/18.
//  Copyright © 2018 Tu (Callie) T. NGUYEN. All rights reserved.
//

import UIKit

class AddNewAccountController: UIViewController {
    
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
        var row = genderPicker.selectedRow(inComponent: 0)
        gender.text = genderData[row]
        self.view.endEditing(true)
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

