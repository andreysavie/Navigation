//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 10.07.2022.
//

import Foundation

protocol LoginViewControllerDelegate: AnyObject {
    
    func signIn (log: String, pass: String)
    func register (log: String, pass: String)
    
}
