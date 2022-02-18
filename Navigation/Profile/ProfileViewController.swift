//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 10.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
//    let header = ProfileHeaderView ()
    
    private lazy var headerView: ProfileHeaderView = {
        
        let headerView = ProfileHeaderView()
        
        headerView.translatesAutoresizingMaskIntoConstraints = false

        
        return headerView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(headerView)
        
        headerView.addProfileViews()
        setupHeaderConstraints()
//        hideKeyboardWhenTappedAround()
        
    }

    
    
    override func viewWillLayoutSubviews() {
        
//        header.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//
//            header.leftAnchor.constraint(equalTo: self.view.leftAnchor),
//            header.rightAnchor.constraint(equalTo: self.view.rightAnchor),
//            header.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
//            header.heightAnchor.constraint(equalToConstant: 220)
//            header.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
//
//        ])
    }
    
    private func setupHeaderConstraints() {
        
        NSLayoutConstraint.activate([
           
            headerView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 220)

        ])
    }

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

