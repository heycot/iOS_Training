//
//  ViewListUserControllerr.swift
//  iOS_Exercise
//
//  Created by Tu (Callie) T. NGUYEN on 1/4/19.
//  Copyright © 2019 Tu (Callie) T. NGUYEN. All rights reserved.
//

import UIKit

class ViewListUserControllerr: UITableViewController{
    
    @IBOutlet var tabelView: UITableView!
    
    var userBo = UserBO()
    var listUser = [User]()
    
    func prepareData() {
        listUser = userBo.getListUser()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listUser.count
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Section \(section)"
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        print("cell ", cell)
        cell.textLabel?.text = listUser[0].name
        cell.detailTextLabel?.text = listUser[0].born
        cell.imageView?.image = UIImage(named: listUser[0].avatar)
        
//        cell.textLabel?.text = headlines[indexPath.row].title
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabelView?.register(UITableViewCell.self, forCellReuseIdentifier: "LabelCell")
    }
}

