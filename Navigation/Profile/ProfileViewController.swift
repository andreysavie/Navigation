//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 10.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    let header = ProfileHeaderView ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(header)
        header.addProfileViews()
        
        self.hideKeyboardWhenTappedAround()

//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.dissmissKeyboard))
//
//        self.view.addGestureRecognizer(tap)
//
    }
    
    override func viewWillLayoutSubviews() {
        
        header.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            header.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            header.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            header.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            header.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    
    


//     @objc func dissmissKeyboard() {
//        view.endEditing(true)
//
//    }
}

extension UIViewController {
func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    view.addGestureRecognizer(tap)
}

@objc func dismissKeyboard() {
    view.endEditing(true)
}
}

