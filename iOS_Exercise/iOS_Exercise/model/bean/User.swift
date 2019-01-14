//
//  User.swift
//  iOS_Exercise
//
//  Created by Tu (Callie) T. NGUYEN on 12/25/18.
//  Copyright © 2018 Tu (Callie) T. NGUYEN. All rights reserved.
//

import Foundation

class User {
    var id:Int64
    var name:String
    var born:String
    var gender:Int64
    var avatar:String
    var description:String
    
    init(id:Int64, name:String, born:String, gender:Int64, avatar:String, description:String) {
        self.id = id
        self.name = name
        self.born = born
        self.gender = gender
        self.avatar = avatar
        self.description = description
    }
    
    convenience init() {
        self.init( id: 0, name: "", born: "", gender: 0, avatar: "", description: "")
    }
    
}
