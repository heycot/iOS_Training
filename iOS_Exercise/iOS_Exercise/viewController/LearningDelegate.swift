//
//  LearningDelegate.swift
//  iOS_Exercise
//
//  Created by Tu (Callie) T. NGUYEN on 1/3/19.
//  Copyright © 2019 Tu (Callie) T. NGUYEN. All rights reserved.
//

import Foundation


//MARK: step 1 Add Protocol here.
//protocol MyDelegate: class {
//    func clickMyButton(string: String)
//    func myViewDidLoad(myVC: UIViewController)
//}
//
//class MyViewController: UIViewController {
//    //MARK: step 2 Create a delegate property here.
//    weak var delegate: MyDelegate?
//
//    var textField: UITextView?
//
//    override func viewDidLoad() {
//
//        delegate?.myViewDidLoad(myVC: self)
//    }
//
//    func clickButton() {
//        delegate?.clickMyButton(string: "My Text")
//    }
//}
//
//class SecondViewController: MyDelegate {
//    let myViewController = MyViewController()
//
//    func myDidLoad() {
//        // Presenet
//        myViewController.delegate = self
//    }
//
//    func myViewDidLoad(myVC: UIViewController) {
//        print("My date")
//    }
//
//    func clickMyButton(string: String) {
//        //
//    }
//
//
//}


//extension UITextField {
//    func setBottomBorder(color: UIColor) {
//        let bottomLine = CALayer()
//        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
//        bottomLine.backgroundColor = color.cgColor
//        self.borderStyle = UITextField.BorderStyle.none
//        self.layer.addSublayer(bottomLine)
//    }
//    
//    func setLeftBorder(color: UIColor) {
//        let bottomLine = CALayer()
//        bottomLine.frame = CGRect(x: -10.0, y: 0.0, width: 1.0, height: self.frame.height)
//        bottomLine.backgroundColor = color.cgColor
//        self.borderStyle = UITextField.BorderStyle.none
//        self.layer.addSublayer(bottomLine)
//    }
//}
