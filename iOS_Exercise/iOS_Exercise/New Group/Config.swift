//
//  Config.swift
//  iOS_Exercise
//
//  Created by Tu (Callie) T. NGUYEN on 1/29/19.
//  Copyright © 2019 Tu (Callie) T. NGUYEN. All rights reserved.
//

import Foundation
import UIKit

public class Config {
    public static let NO_AVATAR: String = "no_avatar"
    public static let HANDLE_AVATAR: [String] = ["Show photo", "Change photo", "Delete photo"]
    
    public static func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    public static func getImage(nameImage: String) -> UIImage?{
        var image : UIImage?
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(nameImage)
        if fileManager.fileExists(atPath: imagePAth){
            image = UIImage(contentsOfFile: imagePAth)
        }else{
            print("No Image")
        }
        return image
        
    }
}
