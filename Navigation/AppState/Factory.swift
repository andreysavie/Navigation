//
//  Factory.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 25.04.2022.
//

import Foundation

// MARK: Задача 4. Создаем фабрику

protocol LoginFactory {
    func returnLoginInspector() -> LoginInspector
}

class MyLoginFactory: LoginFactory {
    
    static let shared = MyLoginFactory()

    func returnLoginInspector() -> LoginInspector {
        let inspector = LoginInspector()
        return inspector
    }
}
