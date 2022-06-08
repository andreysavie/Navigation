//
//  FeedModel.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 12.05.2022.
//

import Foundation
import UIKit

final class FeedViewModel {
    
    //MARK: PROPERTIES
    
    let password = "Password"
    
    private lazy var passwordAlert: UIAlertController = {
        let alertController = UIAlertController(
            title: "Invalid password!",
            message: "",
            preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        return alertController
    }()
    
    //MARK: METHODS
    
    func check(word: String) -> Bool {
        guard word != "" else { return false }
        
        let bool: Bool
        
        if word == password {
            NotificationCenter.default.post(name: NSNotification.Name.codeGreen, object: nil)
            bool = true
        } else {
            NotificationCenter.default.post(name: NSNotification.Name.codeRed, object: nil)
            bool = false
        }
        
        return bool
    }
    
    func presentAlert (viewController: UIViewController) {
        viewController.present(passwordAlert, animated: true, completion: nil)
    }
    
    func setupFeedLayout(newPostButton: UIButton, label: UILabel, textField: UITextField, someButton: UIButton) {
        newPostButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(newPostButton.snp.bottom).offset(16)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        textField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(label.snp.bottom).offset(16)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        someButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(textField.snp.bottom).offset(16)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }
    
}
