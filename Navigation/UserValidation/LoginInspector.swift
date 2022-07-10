//
//  LoginInspector.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 10.07.2022.
//

import Foundation
import FirebaseAuth

class LoginInspector: LoginViewControllerDelegate {
    
    func signIn(log: String, pass: String) {
        UserValidation.shared.checkUser(log: log, pass: pass)
    }
    
    func register(log: String, pass: String) {
        UserValidation.shared.registerUser(log: log, pass: pass)
        
    }
}
