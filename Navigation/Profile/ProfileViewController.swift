//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 10.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: Header

    private lazy var headerTableView: UITableView = {
        
        let headerTableView = UITableView()
        headerTableView.toAutoLayout()
        return headerTableView
        
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(headerTableView)
        
    }
    

    // MARK: Constraints

    private func setupProfileConstraints() {
        
        NSLayoutConstraint.activate([
           
            headerTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            headerTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            headerTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            headerTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

        ])
    }
}

// MARK: Keyboard hedding method

//extension UIViewController {
//    func hideKeyboardWhenTappedAround() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        view.addGestureRecognizer(tap)
//    }
//
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
//}

