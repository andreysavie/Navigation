//
//  Checker.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 24.04.2022.
//
import Foundation

// MARK: Задача 4. Создаем сервис для проверки логина и пароля

final class UserValidation {
    
    static let shared = UserValidation()
    
    private init() {}
    
    private let login = "andreysavie"
    private let pswd = "1234"
    
    func checker (log: String, pass: String) -> Bool {
        guard log == self.login && pass == self.pswd else { return false }
            return true
    }
}
// MARK: Задача 4. Класс для проверки точности введенных данных авторизации

class UserValidationInspector: LoginViewControllerDelegate {
    func userValidation (log: String, pass: String) -> Bool {
        return UserValidation.shared.checker(log: log, pass: pass)
    }
}

