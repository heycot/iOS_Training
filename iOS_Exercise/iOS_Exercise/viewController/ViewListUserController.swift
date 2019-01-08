//
//  ViewListUserController.swift
//  iOS_Exercise
//
//  Created by Tu (Callie) T. NGUYEN on 1/4/19.
//  Copyright © 2019 Tu (Callie) T. NGUYEN. All rights reserved.
//

import UIKit
import SQLite3

class ViewListUserController : UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var userBo = UserBO()
    var listUser = [User]()
    var userSelected = User()
    
    var db: OpaquePointer?
    
    func prepareData() {
        listUser = userBo.getListUser()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareData()
        print("list user :", listUser.count)
        tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView.reloadData()
//        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CellItem")
    }
    
    @objc override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
        cell.name.text = listUser[indexPath.row].name
        cell.born.text = listUser[indexPath.row].born
        
        return cell
    }
    
}

extension ViewListUserController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "ShowUserSelected", sender: listUser[indexPath.row])
    }
    
}



/*
class ViewListUserController: UITableViewController{
    
    @IBOutlet weak var tableUserView: UITableView!
    
    var userBo = UserBO()
    var listUser = [User]()
    var userSelected = User()
    
    func prepareData() {
        listUser = userBo.getListUser()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ViewController
        {
            let vc = segue.destination as? ViewController
            vc?.user = userSelected
        }
    }
    
    override func viewDidLoad() {
         prepareData()
        super.viewDidLoad()
    }
}

extension ViewListUserController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listUser.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "User"
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 117
        
        print("cell ", cell)
        let index = indexPath[1]
        //        cell.textLabel?.text = listUser[index].name
        //        cell.detailTextLabel?.text = listUser[index].born
        
        let uiView : UIView = UIView(frame: CGRect(x:0,y:0,width:375,height:60))
        
        let cellLableName : UILabel = UILabel(frame: CGRect(x:110,y:0,width:265,height:40))
        cellLableName.text = listUser[index].name
        cellLableName.textColor = UIColor.blue
        
        let cellLableBorn : UILabel = UILabel(frame: CGRect(x:110,y:40,width:265,height:20))
        cellLableBorn.text = listUser[index].born
        cellLableBorn.font = cellLableBorn.font.withSize(14)
        
        let cellImg : UIImageView = UIImageView(frame: CGRect(x:0,y:0,width:100,height:60))
        cellImg.image = UIImage(named: listUser[index].avatar)
        
        uiView.addSubview(cellLableName)
        uiView.addSubview(cellLableBorn)
        uiView.addSubview(cellImg)
        
//        cell.imageView?.addSubview(cellImg)
        cell.addSubview(uiView)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath[1]
        userSelected = listUser[index]
        
        self.performSegue(withIdentifier: "ShowDetailUserInList", sender: self)
    }
}
 */


