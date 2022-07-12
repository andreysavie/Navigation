//
//  Authorization.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 11.07.2022.
//

import Foundation
import RealmSwift

class AuthModel: Object {
    
    @objc dynamic var login: String = ""
    @objc dynamic var password: String = ""

}
