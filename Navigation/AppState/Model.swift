//
//  Model.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 07.05.2022.
//

import Foundation
import UIKit

// MARK: - Task 6. part 2. Model. NotificationCenter posts

final class Model {
    
    let password = "Password"
    
    func check(word: String) {
        guard word != "" else { return } // Добавить алерт при пустом значении!
        
        if word == password {
            NotificationCenter.default.post(name: NSNotification.Name.codeGreen, object: nil)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name.codeRed, object: nil)
        }
    }
    
    private lazy var passwordAlert: UIAlertController = {
        let alertController = UIAlertController(
            title: "Invalid password!",
            message: "",
            preferredStyle: .alert)
                
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        return alertController
    }()
}
