//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 10.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: Header

    private lazy var headerView: ProfileHeaderView = {
        
        let headerView = ProfileHeaderView()
        
        headerView.translatesAutoresizingMaskIntoConstraints = false

        return headerView
        
    }()
    
    // MARK: Button "Set title"

    private lazy var setTitleButton: UIButton = {
        
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Set new title", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.titleLabel?.textColor = UIColor.white
        button.backgroundColor = .systemTeal
        
        button.layer.cornerRadius = 4
                
        return button
        
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(headerView)
        self.view.addSubview(setTitleButton)

        headerView.addProfileViews()
        setupProfileConstraints()
        hideKeyboardWhenTappedAround()
        
    }

    // MARK: Constraints

    private func setupProfileConstraints() {
        
        NSLayoutConstraint.activate([
           
            headerView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 220),

            setTitleButton.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            setTitleButton.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            setTitleButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            setTitleButton.heightAnchor.constraint(equalToConstant: 50)

        ])
    }
}

// MARK: Keyboard hedding method

extension ProfileViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

