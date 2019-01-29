//
//  TableUser.swift
//  iOS_Exercise
//
//  Created by Tu (Callie) T. NGUYEN on 1/10/19.
//  Copyright © 2019 Tu (Callie) T. NGUYEN. All rights reserved.
//

import Foundation
import SQLite

class TableUser{
    public static let shared = TableUser()
    
    private let tableUser = Table("user")
    
    private let id = Expression<Int64>("id")
    private let name = Expression<String>("name")
    private let born = Expression<String>("born")
    private let gender = Expression<Int64>("gender")
    private let avatar = Expression<String>("avatar")
    private let description = Expression<String>("description")
    
    init() {
        do {
            if let connection = Database.db.connection {
                try connection.run(tableUser.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (table) in
                    table.column(self.id, primaryKey: true)
                    table.column(self.name)
                    table.column(self.born)
                    table.column(self.gender)
                    table.column(self.avatar)
                    table.column(self.description)
                }))
                print("create user table is successfully")
                
            } else {
                print("create user table is faild")
            }
            
        } catch {
            let nsError = error as NSError
            print("error init user: \(nsError) / \(nsError.userInfo)")
        }
    }
    
    
    func insert(name:String, born:String, gender:Int64, avatar:String, description:String) -> Int64? {
        do {
            let insert = tableUser.insert(self.name <- name, self.born <- born, self.gender <- gender, self.avatar <- avatar, self.description <- description)
            let insertedId = try Database.db.connection!.run(insert)
            
            return insertedId
        } catch {
            let nsError = error as NSError
            print("error init user: \(nsError) / \(nsError.userInfo)")
            return nil
        }
    }
    
    func findAll() -> [User] {
        var users = [User]()
        
        do {
            for user in try (Database.db.connection?.prepare(self.tableUser))! {
                users.append( User(id: user[id],  name: user[name], born: user[born], gender: user[gender], avatar: user[avatar], description: user[description]))
            }
        } catch {
            print("Select failed")
        }
        
        return users
    }
    
    func findFirstUser() -> User {
        var result = User()
        do {
            for user in try (Database.db.connection?.prepare(self.tableUser))! {
                result = User(id: user[id],  name: user[name], born: user[born], gender: user[gender], avatar: user[avatar], description: user[description])
                break
            }
        } catch {
            print("Select failed")
        }
        
        return result
    }
    
    func deleteOneUser(rowId: Int64) -> Bool {
        do {
            
            let alice = tableUser.filter(id == rowId)
            try Database.db.connection?.run(alice.delete())
            return true
        } catch {
            print("delete failed")
        }
        
        return false
    }
    
    func changeAvatar(rowId: Int64, avatarName: String) -> Bool {
        do {
            let edit = tableUser.filter(id == rowId)
//            try Database.db.connection?.run(edit.update(avatar <- avatar.replace("", with: "no_avatar")))
            
            try Database.db.connection?.run(edit.update(avatar <- avatarName))
            
            return true
        } catch {
            print("delete avatar failed")
        }
        
        return false
    }
    
    func findOneById(rowId: Int64) -> User {
        var user = User()
        do {
            let query = tableUser.filter(id == rowId)
            for row in try (Database.db.connection?.prepare(query))! {
               user = User(id: row[id],  name: row[name], born: row[born], gender: row[gender], avatar: row[avatar], description: row[description])
            }
        } catch {
            print("find one failed (exception)")
        }
        
        return user
    }
}

