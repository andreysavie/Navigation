//
//  Checker.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 24.04.2022.
//
import Foundation
import FirebaseAuth


final class UserValidation {
    
    static let shared = UserValidation()
    
    var completion: ((_ message: String) -> Void)?

    
    private init() {}
    
    public func checkUser ( log: String, pass: String) {

        Auth.auth().signIn(withEmail: log, password: pass) { [weak self] authResult, error in
            guard let self = self else { return }
            if let error = error {
                if let completion = self.completion {
                    completion (error.localizedDescription)
                }
            }
        }
    }
    
    public func registerUser (log: String, pass: String) {
        
        Auth.auth().createUser(withEmail: log, password: pass) { [weak self] authResult, error in
            guard let self = self else { return }
            if let error = error {
                if let completion = self.completion {
                    completion (error.localizedDescription)
                }
            }
        }
    }
    
}
