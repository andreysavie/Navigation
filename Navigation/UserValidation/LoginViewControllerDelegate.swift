//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 10.07.2022.
//

import Foundation

protocol LoginViewControllerDelegate: AnyObject {
    
    func signing (signType: SignType, log: String, pass: String)
    
}
