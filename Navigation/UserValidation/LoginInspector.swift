//
//  LoginInspector.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 10.07.2022.
//

import Foundation

class LoginInspector: LoginViewControllerDelegate {
    
    func signing (signType: SignType, log: String, pass: String) {
        UserValidation.shared.checkUser( signType: signType, log: log, pass: pass)
    }
}

