//
//  LoginFactory.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 10.07.2022.
//

import Foundation

protocol LoginFactory {
    
    func returnLoginInspector() -> LoginViewControllerDelegate
    
}
