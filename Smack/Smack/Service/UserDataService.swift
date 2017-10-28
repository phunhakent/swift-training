//
//  UserDataService.swift
//  Smack
//
//  Created by Kent Nguyen on 10/27/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserDataService {
    static let instance = UserDataService()
    
    private(set) var id = ""
    private(set) var avatarColor = ""
    private(set) var avatarName = ""
    private(set) var email = ""
    private(set) var name = ""
    
    func setUserData(id: String, color: String, avatarName: String, email: String, name: String) {
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }
    
    func returnUIColor(components: String) -> UIColor {
        let scanner = Scanner(string: components)
        let comma = CharacterSet(charactersIn: ",")
        
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "[], ")
        
        var r, g, b, a: NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        
        guard let red = r?.doubleValue,
            let green = g?.doubleValue,
            let blue = b?.doubleValue,
            let alpha = a?.doubleValue else {
            return defaultColor
        }
        
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }
    
}
