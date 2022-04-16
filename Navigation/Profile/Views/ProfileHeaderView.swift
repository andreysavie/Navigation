//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 17.02.2022.
//

import UIKit
import SnapKit


class ProfileHeaderView: UITableViewHeaderFooterView, UITextFieldDelegate {
    
    static let identifire = "ProfileHeaderView"
    private var status: String = ""
    var defaultAvatarCenter: CGPoint = CGPoint(x: 0, y: 0)
    
    private lazy var blurEffectView: UIVisualEffectView = {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        blurEffectView.layer.opacity = 0
        blurEffectView.isUserInteractionEnabled = false
        
        
        return blurEffectView
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
        nameLabel.text = "Andrey Rybalkin"
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return nameLabel
        
    }()
    
    // MARK: Status
    
    private lazy var statusLabel: UILabel = {
        
        let statusLabel = UILabel()
        statusLabel.text = "Waiting for something..."
        statusLabel.numberOfLines = 2
        statusLabel.textColor = .darkGray
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return statusLabel
        
    }()
    
    // MARK: Status textField
    
    lazy var statusTextField: UITextField = {
        
        let statusTextField = UITextField()
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
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        return statusTextField
        
    }()
    
    // MARK: Button "Show status"
    
    private lazy var showStatusButton: UIButton = {
        
        let button = UIButton()
        
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
        contentView.addSubviews(nameLabel, statusLabel, statusTextField, showStatusButton, blurEffectView, avatar, xmarkButton)
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
            self.avatar.center = CGPoint(x: UIScreen.main.bounds.midX, y: (UIScreen.main.bounds.midY + ProfileViewController.tableView.contentOffset.y))
            self.avatar.transform = CGAffineTransform(scaleX: self.contentView.frame.width / self.avatar.frame.width, y: self.contentView.frame.width / self.avatar.frame.width)
            self.avatar.layer.cornerRadius = 0
            self.avatar.layer.borderWidth = 0
            self.avatar.isUserInteractionEnabled = false
            self.showStatusButton.isUserInteractionEnabled = false
            self.statusTextField.isUserInteractionEnabled = false
            self.blurEffectView.layer.opacity = 1
            ProfileViewController.tableView.isScrollEnabled = false
            ProfileViewController.tableView.cellForRow(at: IndexPath(item: 0, section: 0))?.isUserInteractionEnabled = false
            ProfileViewController.tableView.cellForRow(at: IndexPath(item: 0, section: 1))?.isUserInteractionEnabled = false
            
        },
                            completion: { _ in
            UIImageView.animate(withDuration: 0.3) {
                self.xmarkButton.layer.opacity = 1
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
                self.blurEffectView.layer.opacity = 0
                self.showStatusButton.isUserInteractionEnabled = true
                self.statusTextField.isUserInteractionEnabled = true
                ProfileViewController.tableView.isScrollEnabled = true
                ProfileViewController.tableView.cellForRow(at: IndexPath(item: 0, section: 0))?.isUserInteractionEnabled = true
                ProfileViewController.tableView.cellForRow(at: IndexPath(item: 0, section: 1))?.isUserInteractionEnabled = true
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
        
        avatar.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.top.equalToSuperview().inset(Constants.indent)
            make.leading.equalToSuperview().inset(Constants.leadingMargin)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatar.snp.trailing).inset(-20) // ?????? чооооооо
            make.top.equalToSuperview().inset(27)
            make.trailing.equalToSuperview().inset(Constants.indent)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatar.snp.trailing).inset(-20) // or +20??
            make.bottom.equalTo(statusTextField.snp.top).inset(-12) // or +?
            make.trailing.greaterThanOrEqualToSuperview().inset(16)
        }
        
        showStatusButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.indent)
            make.top.equalTo(avatar.snp.bottom).inset(-Constants.indent) // отрицательное??
            make.height.equalTo(50)
        }
        
        statusTextField.snp.makeConstraints { make in
            make.leading.equalTo(avatar.snp.trailing).inset(-20) //-20??
            make.trailing.greaterThanOrEqualToSuperview().inset(Constants.indent) // tr marg
            make.bottom.equalTo(showStatusButton.snp.top).inset(-12) // or +?
            make.height.equalTo(40)
        }
        
        xmarkButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(Constants.indent)
        }
    }
}
