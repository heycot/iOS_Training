//
//  ViewListUserController.swift
//  iOS_Exercise
//
//  Created by Tu (Callie) T. NGUYEN on 1/4/19.
//  Copyright © 2019 Tu (Callie) T. NGUYEN. All rights reserved.
//

import UIKit
import Darwin

class ViewListUserController : UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var userBo = UserBO()
    var listUser = [User]()
    var userSelected = User()
    
    func prepareData() {
        listUser = userBo.getListUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        navigationItem.hidesBackButton = true
        
        prepareData()
        print("list user :", listUser.count)
        tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView.reloadData()
        tableView.estimatedRowHeight = UITableView.automaticDimension
//        tableView.rowHeight = UITableView.automaticDimension
        tableView.rowHeight = 70
        
    }
    
    @objc override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        let navVC = segue.destination as? UINavigationController
//        if navVC?.viewControllers.first is ViewController {
//            let vc = navVC?.viewControllers.first as? ViewController
//            vc?.user = sender as! User
//        }
        
        if segue.destination is ViewController
        {
            let vc = segue.destination as? ViewController
            vc?.user = sender as! User
        }
    }
}

extension ViewListUserController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellItem") as! CustomTableViewCell

        cell.avatar.image = UIImage(named: listUser[indexPath.row].avatar)
        cell.avatar.setRounded(color: UIColor(red: CGFloat(81.0/255.0), green: CGFloat(110.0/255.0), blue: CGFloat(173.0/255.0), alpha: CGFloat(1.0)))
        cell.name.text = listUser[indexPath.row].name
        cell.born.text = listUser[indexPath.row].born

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            if userBo.deleteOneUser(rowId: listUser[indexPath.row].id) {
                
                listUser.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .bottom)
            }
        }
    }
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//
////        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
////            //TODO: edit the row at indexPath here
////        }
////        editAction.backgroundColor = UIColor(patternImage: UIImage(named: "edit_icon")!)
//
//        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (rowAction, indexPath) in
//            //TODO: Delete the row at indexPath here
//        }
//        deleteAction.backgroundColor =  UIColor(patternImage: UIImage(named: "delete_icon")!)
//
////        return [editAction,deleteAction]
//        
//        return [deleteAction]
//    }
}

extension ViewListUserController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowUserSelected", sender: listUser[indexPath.row])
    }
    
}


extension UIImageView {
    
    func setRounded(color: UIColor) {
        self.layer.cornerRadius = (self.frame.size.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.layer.borderWidth = 3.0
        self.layer.borderColor = color.cgColor
    }
}



