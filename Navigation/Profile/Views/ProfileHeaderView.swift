//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 17.02.2022.
//

import UIKit
import SnapKit

class ProfileHeaderView: UITableViewHeaderFooterView, UITextFieldDelegate {

    // MARK: PROPERTIES

    static let identifire = "ProfileHeaderView"
    private var status: String = ""
    private var defaultAvatarCenter: CGPoint = CGPoint(x: 0, y: 0)
    
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
    
    public lazy var avatar: UIImageView = {
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
        
    public lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Andrey Rybalkin"
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return nameLabel
    }()
        
    public lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = "Waiting for something..."
        statusLabel.numberOfLines = 2
        statusLabel.textColor = .darkGray
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return statusLabel
    }()
        
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
    
    
    // MARK: INITS
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(
            nameLabel,
            statusLabel,
            statusTextField,
            showStatusButton,
            blurEffectView,
            avatar,
            xmarkButton
        )
        setupHeaderLayout()
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
    
    private func setupHeaderLayout() {
        
        avatar.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.top.leading.equalTo(contentView).inset(Constants.margin)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatar.snp.trailing).offset(Constants.offset)
            make.top.equalTo(contentView).inset(27)
            make.trailing.equalTo(contentView).inset(Constants.margin)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatar.snp.trailing).offset(Constants.offset)
            make.bottom.equalTo(statusTextField.snp.top).offset(-12)
            make.trailing.greaterThanOrEqualTo(contentView).inset(Constants.margin)
        }
        
        showStatusButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView).inset(Constants.margin)
            make.top.equalTo(avatar.snp.bottom).offset(Constants.margin)
            make.height.equalTo(50)
        }
        
        statusTextField.snp.makeConstraints { make in
            make.leading.equalTo(avatar.snp.trailing).offset(Constants.offset)
            make.trailing.greaterThanOrEqualTo(contentView).inset(Constants.margin)
            make.bottom.equalTo(showStatusButton.snp.top).offset(-12)
            make.height.equalTo(Constants.offset * 2)
        }
                
        xmarkButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(contentView).inset(Constants.margin)
        }
    }
}
