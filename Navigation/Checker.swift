//
//  Checker.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 24.04.2022.
//

import Foundation

final class Checker {
    
    static let shared = Checker()
    
    private init() {}
    
    private let login = "andreysavie"
    private let pswd = "1234"
    
    func logPassChecker (log: String, pass: String) -> Bool {
        guard log == self.login && pass == self.pswd else { return false }
            return true
    }
}

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
