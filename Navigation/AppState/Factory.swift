//
//  Factory.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 25.04.2022.
//

import Foundation

// MARK: Задача 4. Создаем фабрику

protocol LoginFactory {
    func returnLoginInspector() -> UserValidationInspector
}

class MyLoginFactory: LoginFactory {
    
    static let shared = MyLoginFactory()

    func returnLoginInspector() -> UserValidationInspector {
        let inspector = UserValidationInspector()
        return inspector
    }
}
