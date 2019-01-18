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
    
    @IBAction func cancelBtnClick(_ sender: Any) {
        exit(0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        prepareData()
        print("list user :", listUser.count)
        tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView.reloadData()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @objc override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navVC = segue.destination as? UINavigationController
        if navVC?.viewControllers.first is ViewController {
            let vc = navVC?.viewControllers.first as? ViewController
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
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return  500.0
//    }
    
}

extension ViewListUserController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowUserSelected", sender: listUser[indexPath.row])
    }
}




