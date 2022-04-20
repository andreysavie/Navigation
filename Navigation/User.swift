//
//  User.swift
//  
//
//  Created by Андрей Рыбалкин on 19.04.2022.
//

import Foundation
import UIKit

protocol UserService {
    func userIdentify (name: String) -> User?
}

final class User {
    
    let name: String
    let status: String
    let avatar: UIImage
    
    init ( name: String, status: String, avatar: UIImage) {
        self.name = name
        self.status = status
        self.avatar = avatar
    }
    
}

final class CurrentUserService: UserService {
    
    private let user: User
    
    init (user: User) {
        self.user = user
    }
    
    
    func userIdentify(name: String) -> User? {
        
        guard name == user.name else { return nil }
        return self.user
    }
    
    


}
