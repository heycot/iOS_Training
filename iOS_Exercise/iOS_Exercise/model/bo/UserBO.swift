//
//  UserBO.swift
//  iOS_Exercise
//
//  Created by Tu (Callie) T. NGUYEN on 12/26/18.
//  Copyright © 2018 Tu (Callie) T. NGUYEN. All rights reserved.
//

import Foundation

class UserBO{
    var users : [User]
    init() {
        users = []
       initSomeAccount()
    }
    
    func initSomeAccount() {
        let charlie = User(name: "Charlie Puth",
                           born: "December 2, 1991",
                           gender: "Male",
                           avatar: "Charlie_Puth",
                           description: "Charles Otto Puth Jr is an American singer, songwriter and record producer. His initial exposure came through the viral success of his song videos uploaded to YouTube.")
        users.append(charlie)
        
        let taylor = User(name: "Taylor Swift",
                          born: "December 13, 1989",
                          gender: "Female",
                          avatar: "Taylor_Swift",
                          description: "Taylor Alison Swift is an American singer-songwriter. As one of the world's leading contemporary recording artists, she is known for narrative songs about her personal life, which have received widespread media coverage.")
        users.append(taylor)
        
        let justin = User(name: "Justin Bieber",
                          born: "March 1, 1994",
                          gender: "Male",
                          avatar: "Justin_Bieber",
                          description: "Justin Drew Bieber is a Canadian singer-songwriter. After talent manager Scooter Braun discovered him through his YouTube videos covering songs in 2008 and he signed to RBMG, Bieber released his debut EP, My World, in late 2009. It was certified platinum in the US. He became the first artist to have seven songs from a debut record chart on the Billboard Hot 100. Bieber released his first full-length studio album, My World 2.0, in 2010. It debuted at number one in several countries, was certified triple platinum in the US, and contained his single 'Baby'.")
        users.append(justin)
    }
    
    func getListUser() -> [User]{
        return users
    }
    
    func addOneUser(user:User) -> Bool{
        if (user.name != "") {
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
        return users[0]
    }
    
}
