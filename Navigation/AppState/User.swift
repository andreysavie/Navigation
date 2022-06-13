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
    
    let fullName: String
    let status: String
    let avatar: UIImage?
    
    init ( name: String, status: String, avatar: UIImage) {
        self.fullName = name
        self.status = status
        self.avatar = avatar
    }
}

final class CurrentUserService: UserService {
    
    let user = User(
        name: "Andrey Rybalkin",
        status: "Release mode!",
        avatar: UIImage(named: "avatar")!
    )
  
    
    func userIdentify(name: String) -> User? {
        guard name == user.fullName else { return nil }
        return self.user
    }
}

final class TestUserService: UserService {

    let user = User(
        name: "Andrey Savie",
        status: "Debug make drink!",
        avatar: UIImage(named: "debug")!
    )
    
    
    func userIdentify(name: String) -> User? {
//        guard name == user.fullName else { return nil } Временно закомментировал для 4 домашки
        return self.user
    }
}
