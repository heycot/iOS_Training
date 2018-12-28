//
//  UserBO.swift
//  iOS_Exercise
//
//  Created by Tu (Callie) T. NGUYEN on 12/26/18.
//  Copyright © 2018 Tu (Callie) T. NGUYEN. All rights reserved.
//

import Foundation

class UserBO{
    var users = [User]()
    init() {}
    
    func getListUser() -> [User]{
        return users
    }
    
    func addOneUser(user:User) -> Bool{
        if (user != nil) {
            users.append(user)
            return true
        } else {
            return false
        }
    }
    
    func removeOneUser(index:Int) -> Bool{
        if (index >= 0 && index < users.count) {
            users.remove(at: index)
            return true
        } else {
            return false
        }
    }
    
    func getUserDefault() -> User {
        let charlie = User(name: "Charlie Puth",
                           born: "December 2, 1991",
                           gender: "Male",
                           avatar: "Charlie_Puth",
                           description: "Charles Otto Puth Jr is an American singer, songwriter and record producer. His initial exposure came through the viral success of his song videos uploaded to YouTube.")
        users.append(charlie)
        return charlie
    }
}
