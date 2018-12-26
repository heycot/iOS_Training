//
//  User.swift
//  iOS_Exercise
//
//  Created by Tu (Callie) T. NGUYEN on 12/25/18.
//  Copyright © 2018 Tu (Callie) T. NGUYEN. All rights reserved.
//

import Foundation

class User {
    
    var name:String
    var born:String
    var gender:Int
    var avatar:String
    var description:String
    
    init(name:String, born:String, gender:Int, avatar:String, description:String) {
        self.name = name
        self.born = born
        self.gender = gender
        self.avatar = avatar
        self.description = description
    }
    
}
