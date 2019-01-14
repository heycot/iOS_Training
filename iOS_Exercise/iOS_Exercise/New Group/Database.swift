//
//  database.swift
//  iOS_Exercise
//
//  Created by Tu (Callie) T. NGUYEN on 1/8/19.
//  Copyright © 2019 Tu (Callie) T. NGUYEN. All rights reserved.
//

import Foundation
import SQLite

class Database {
    static let db = Database()
    
    public let connection : Connection?
    public let dbFileName = "idol.sqlite3"
    
    private init() {
        let dbPath =  NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        do {
            connection = try Connection("\(dbPath)/ \(dbFileName)")
        } catch {
            connection = nil
            let nsError = error as NSError
            print("can not connect to the database. cause \(nsError)")
            
        }
    }
}
