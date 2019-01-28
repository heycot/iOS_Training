//
//  UserBO.swift
//  iOS_Exercise
//
//  Created by Tu (Callie) T. NGUYEN on 12/26/18.
//  Copyright © 2018 Tu (Callie) T. NGUYEN. All rights reserved.
//

import Foundation

class UserBO{
    
    public static let userBo = UserBO()
    
    init() {
        initSomeAccount()
    }
    
    
    func initSomeAccount() {
        
        if (TableUser.shared.findAll().count == 0) {
            _ = TableUser.shared.insert(name: "Charlie Puth",
                                        born: "December 2, 1991",
                                        gender: 0,
                                        avatar: "Charlie_Puth",
                                        description: "Charles Otto Puth Jr is an American singer, songwriter and record producer. His initial exposure came through the viral success of his song videos uploaded to YouTube.")
            
            _ = TableUser.shared.insert(name: "Taylor Swift",
                                        born: "December 13, 1989",
                                        gender: 1,
                                        avatar: "Taylor_Swift",
                                        description: "Taylor Alison Swift is an American singer-songwriter. As one of the world's leading contemporary recording artists, she is known for narrative songs about her personal life, which have received widespread media coverage.")
            
            _ = TableUser.shared.insert(name: "Justin Bieber",
                                        born: "March 1, 1994",
                                        gender: 0,
                                        avatar: "Justin_Bieber",
                                        description: "Justin Drew Bieber is a Canadian singer-songwriter. After talent manager Scooter Braun discovered him through his YouTube videos covering songs in 2008 and he signed to RBMG, Bieber released his debut EP, My World, in late 2009. It was certified platinum in the US. He became the first artist to have seven songs from a debut record chart on the Billboard Hot 100. Bieber released his first full-length studio album, My World 2.0, in 2010. It debuted at number one in several countries, was certified triple platinum in the US, and contained his single 'Baby'.")
        }
        
    }
    
    
    func getListUser() -> [User] {
       return TableUser.shared.findAll()
    }
    
    func  getUserDefault() -> User{
        return TableUser.shared.findFirstUser()
    }
    
    func addOneUser(user:User) -> Bool{
        let newUserId = TableUser.shared.insert(name: user.name, born: user.born, gender: user.gender, avatar: user.avatar, description: user.description)
        
        if (newUserId != nil) {
            return true
        } else {
            return false
        }
        
    }
    
    
    
    func deleteOneUser(rowId: Int64) -> Bool{
        return TableUser.shared.deleteOneUser(rowId: rowId)
    }
    
    func deleteAvatar(rowId: Int64) -> Bool {
        
        return TableUser.shared.deleteAvatar(rowId: rowId)
    }
    
}
