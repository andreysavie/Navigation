//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 17.02.2022.
//

import UIKit


class ProfileHeaderView: UITableViewHeaderFooterView, UITextFieldDelegate {
    
    static let identifire = "ProfileHeaderView"
    private var status: String = ""
    var defaultAvatarCenter: CGPoint = CGPoint(x: 0, y: 0)

    
    private lazy var backView: UIView = {
        let View = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        View.toAutoLayout()
        View.backgroundColor = .black
        View.layer.opacity = 0
        return View
    }()
    
    private lazy var xmarkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.layer.opacity = 0
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(self.hideAvatar), for: .touchUpInside)
        return button
    }()

    
    // MARK: Avatar
        
    private lazy var avatar: UIImageView = {
        
        let avatar = UIImageView()
        avatar.toAutoLayout()
        avatar.clipsToBounds = true
        avatar.image = UIImage(named: "avatar")
        avatar.contentMode = .scaleAspectFill
        avatar.layer.cornerRadius = 50
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = UIColor.white.cgColor
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.showAvatar))
        recognizer.numberOfTapsRequired = 1
        avatar.addGestureRecognizer(recognizer)
        avatar.isUserInteractionEnabled = true

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

    lazy var statusTextField: UITextField = {
        
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
        statusTextField.leftViewMode = .always
        statusTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: statusTextField.frame.height))

        statusTextField.autocorrectionType = UITextAutocorrectionType.no
        statusTextField.keyboardType = UIKeyboardType.default
        statusTextField.returnKeyType = UIReturnKeyType.done
        statusTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        statusTextField.isEnabled = true
        statusTextField.isUserInteractionEnabled = true
//        statusTextField.delegate = self
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
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        return button
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(nameLabel, statusLabel, statusTextField, showStatusButton, backView, avatar, xmarkButton)
        setupConstraints()
        
        statusTextField.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: METHODS

    @objc func showAvatar() {
        UIImageView.animate(withDuration: 0.5,
                            animations: {
            self.defaultAvatarCenter = self.avatar.center
            self.avatar.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
            self.avatar.transform = CGAffineTransform(scaleX: self.contentView.frame.width / self.avatar.frame.width, y: self.contentView.frame.width / self.avatar.frame.width)
            self.avatar.layer.cornerRadius = 0
            self.avatar.layer.borderWidth = 0
            self.avatar.isUserInteractionEnabled = false
            self.backView.layer.opacity = 0.5
             ProfileViewController.tableView.isScrollEnabled = false
             ProfileViewController.tableView.cellForRow(at: IndexPath(item: 0, section: 0))?.isUserInteractionEnabled = false
        },
                            completion: { _ in
            UIImageView.animate(withDuration: 0.3) {
                self.xmarkButton.alpha = 1
            }
        })
    }
    
    @objc func hideAvatar() {
        UIImageView.animate(withDuration: 0.3,
                            animations: {
            self.xmarkButton.layer.opacity = 0
        },
                            completion: { _ in
            UIImageView.animate(withDuration: 0.5) {
                self.avatar.center = self.defaultAvatarCenter
                self.avatar.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.avatar.layer.cornerRadius = self.avatar.frame.width / 2
                self.avatar.layer.borderWidth = 3
                self.avatar.isUserInteractionEnabled = true
                self.backView.layer.opacity = 0
                ProfileViewController.tableView.isScrollEnabled = true
                ProfileViewController.tableView.cellForRow(at: IndexPath(item: 0, section: 0))?.isUserInteractionEnabled = true
            }
        })
    }
    
    
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        return true
    }


    //     MARK: Constraints
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            avatar.widthAnchor.constraint(equalToConstant: 100),
            avatar.heightAnchor.constraint(equalToConstant: 100),
            avatar.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.indent),
            avatar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leadingMargin),
            
            nameLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            nameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: Constants.trailingMargin),
            
            showStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leadingMargin),
            showStatusButton.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: Constants.trailingMargin),
            showStatusButton.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: Constants.indent),
            showStatusButton.heightAnchor.constraint(equalToConstant: 50),
            
            statusTextField.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 20),
            statusTextField.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: Constants.trailingMargin),
            statusTextField.bottomAnchor.constraint(equalTo: showStatusButton.topAnchor, constant: -12),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            statusLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 20),
            statusLabel.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -12),
            statusLabel.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: Constants.trailingMargin),
            
            xmarkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.indent),
            xmarkButton.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.indent)

        ])
    }
}
