//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 17.02.2022.
//

import UIKit


class ProfileHeaderView: UIView, UITextFieldDelegate {
    
    private var status: String = ""
    
    // MARK: Avatar
    
    private lazy var avatar: UIImageView = {
        
        let avatar = UIImageView()
        
        avatar.toAutoLayout()
        
        avatar.clipsToBounds = true
        avatar.image = UIImage(named: "avatar")
        avatar.layer.cornerRadius = 50
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = UIColor.white.cgColor
        
        return avatar
        
    }()
    
    // MARK: Name

    private lazy var nameLabel: UILabel = {
        
        let nameLabel = UILabel()
        
        nameLabel.toAutoLayout()
        
        nameLabel.text = "Andrey Rybalkin"
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        return nameLabel
        
    }()
    
    // MARK: Status
    
    private lazy var statusLabel: UILabel = {
        
        let statusLabel = UILabel()
        
        statusLabel.toAutoLayout()
        
        statusLabel.text = "Waiting for something..."
        statusLabel.numberOfLines = 2
        statusLabel.textColor = .darkGray
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        return statusLabel
        
    }()
    
    // MARK: Status textField

    private lazy var statusTextField: UITextField = {
        
        let statusTextField = UITextField()
        
        statusTextField.toAutoLayout()
        
        statusTextField.layer.cornerRadius = 12
        statusTextField.clipsToBounds = true
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.backgroundColor = .white
        
        statusTextField.placeholder = "Enter your status..."
        
        statusTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusTextField.textColor = .black
        statusTextField.textAlignment = .center
        
        statusTextField.autocorrectionType = UITextAutocorrectionType.no
        statusTextField.keyboardType = UIKeyboardType.default
        statusTextField.returnKeyType = UIReturnKeyType.done
        statusTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        statusTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        statusTextField.isEnabled = true
        statusTextField.isUserInteractionEnabled = true
        statusTextField.delegate = self
        
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        return statusTextField
        
    }()
    
    // MARK: Button "Show status"

    private lazy var showStatusButton: UIButton = {
        
        let button = UIButton()
        
        button.toAutoLayout()
        
        button.setTitle("Show status", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.titleLabel?.textColor = UIColor.white
        button.backgroundColor = .systemTeal

        button.layer.cornerRadius = 4
        
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        return button
        
    }()
       
    
    // MARK: METHODS

    @objc func buttonPressed(sender: UIButton!) {
        
        guard statusTextField.text?.isEmpty == false else {return}
        
        statusLabel.text = statusTextChanged(statusTextField)
        self.statusTextField.text = ""
        
    }
    
    
    @objc func statusTextChanged(_ textField: UITextField) -> String {
        
        if let newStatus = textField.text {
            status = newStatus
        }
        
        return status
        
    }
    
    
    func addProfileViews () {
        
        addSubviews(avatar,
                    nameLabel,
                    statusLabel,
                    statusTextField,
                    showStatusButton)
        self.setupConstraints()
        
    }
    
    //     MARK: Constraints
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            avatar.widthAnchor.constraint(equalToConstant: 100),
            avatar.heightAnchor.constraint(equalToConstant: 100),
            avatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            avatar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            
            nameLabel.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            nameLabel.rightAnchor.constraint(greaterThanOrEqualTo: self.rightAnchor, constant: -16),
            
            showStatusButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            showStatusButton.rightAnchor.constraint(greaterThanOrEqualTo: self.rightAnchor, constant: -16),
            showStatusButton.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 16),
            showStatusButton.heightAnchor.constraint(equalToConstant: 50),
            
            statusTextField.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 20),
            statusTextField.rightAnchor.constraint(greaterThanOrEqualTo: self.rightAnchor, constant: -16),
            statusTextField.bottomAnchor.constraint(equalTo: showStatusButton.topAnchor, constant: -12),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            statusLabel.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 20),
            statusLabel.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -12),
            statusLabel.rightAnchor.constraint(greaterThanOrEqualTo: self.rightAnchor, constant: -16),
            
        ])
    }
}

public extension UIView {

    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }

}

