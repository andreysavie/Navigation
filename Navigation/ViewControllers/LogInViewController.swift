//
//  LogInViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 20.02.2022.
//

import UIKit
import SnapKit

protocol LoginViewControllerDelegate {
    func userValidation (log: String, pass: String) -> Bool
}

class LoginInspector: LoginViewControllerDelegate {
    func userValidation (log: String, pass: String) -> Bool {
        return Checker.shared.logPassChecker(log: log, pass: pass)
    }
}

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: PROPERTY
    
    private var isLogin = false
    
    var delegate: LoginViewControllerDelegate!

    private lazy var logInScrollView: UIScrollView = {
        let logInScrollView = UIScrollView()
//        logInScrollView.toAutoLayout()
        return logInScrollView
    }()
    
    private lazy var contentView: UIView = {
        let logInHeaderView = UIView()
//        logInHeaderView.toAutoLayout()
        return logInHeaderView
    }()
    
    private lazy var logo: UIImageView = {
        let logo = UIImageView()
//        logo.toAutoLayout()
        logo.image = UIImage(named: "logo")
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginTextField, passwordTextField])
//        stackView.toAutoLayout()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = .systemGray6
        stackView.clipsToBounds = true
        return stackView
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.textColor = UIColor.white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
        button.alpha = 0.5
        button.isEnabled = false
        return button
    }()
    
    // MARK: METHODS
    
    private func logPassTextField(placeholder: String, secure: Bool) ->  UITextField {
        let logPassTextField = UITextField()
        
//        logPassTextField.toAutoLayout()
        logPassTextField.leftViewMode = .always
        logPassTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: logPassTextField.frame.height))
        
        logPassTextField.placeholder = placeholder
        logPassTextField.layer.borderColor = UIColor.lightGray.cgColor
        logPassTextField.layer.borderWidth = 0.25
        logPassTextField.textColor = .black
        logPassTextField.font = UIFont.systemFont(ofSize: 16)
        
        logPassTextField.autocorrectionType = .no
        logPassTextField.autocapitalizationType = .none
        logPassTextField.keyboardType = .emailAddress
        logPassTextField.returnKeyType = .done
        logPassTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        logPassTextField.isSecureTextEntry = secure
        
        return logPassTextField
    }
    
    public lazy var loginTextField: UITextField = {
        let textField = logPassTextField(placeholder: "Email or phone", secure: false)
        textField.addTarget(self, action: #selector(logInButtonAlpha), for: .editingChanged)
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = logPassTextField(placeholder: "Password", secure: true)
        textField.addTarget(self, action: #selector(logInButtonAlpha), for: .editingChanged)
        return textField
    }()
    
    private lazy var loginAlertController: UIAlertController = {
        let alertController = UIAlertController(
            title: "⚠️ User not found! ⚠️",
            message: "please check login or password",
            preferredStyle: .alert)
        
        let acceptAction = UIAlertAction(title: "OK", style: .default) { (_) -> Void in
        }
        alertController.addAction(acceptAction)
        return alertController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        setupContentViews()
        hideKeyboardWhenTappedAround()
        
        
    }
    // Subscribing for keyboard notifications
    
    override func viewDidAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardShow),
            name: UIResponder.keyboardWillShowNotification, object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardHide),
            name: UIResponder.keyboardWillHideNotification, object: nil
        )
    }
    
    // Unsubscribing from keyboard notifications
    
    override func viewDidDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // method of views composition building
    
    private func setupContentViews() {
        view.backgroundColor = .white
        view.addSubview(logInScrollView)
        logInScrollView.addSubview(contentView)
        contentView.addSubviews(logo, textFieldsStackView, logInButton)
        textFieldsStackView.addArrangedSubview(loginTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        setupLoginLayout()
    }
    
    // MARK: CONSTRAINTS
    
    private func setupLoginLayout() {
        
        logInScrollView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.centerX.centerY.equalTo(logInScrollView)
        }
        
        logo.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.top.equalTo(contentView).offset(120)
            make.centerX.equalTo(contentView)
        }
        
        textFieldsStackView.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).offset(120)
            make.leading.trailing.equalTo(contentView).inset(Constants.margin)
            make.height.equalTo(100)
        }
        
        logInButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldsStackView.snp.bottom).offset(Constants.margin)
            make.leading.trailing.equalTo(contentView).inset(Constants.margin)
            make.height.equalTo(50)
        }
}
    
    //MARK: METHODS
    
    @objc private func logInButtonPressed(sender: UIButton!) {
        
//        #if DEBUG
        let currentUserService = TestUserService()
//        #else
//        let currentUserService = CurrentUserService()
//        #endif

        let profileVC = ProfileViewController(userService: currentUserService, name: loginTextField.text!)
        
        if delegate?.userValidation(log: loginTextField.text!, pass: passwordTextField.text!) == true {
                isLogin = true
                navigationController?.pushViewController(profileVC, animated: true)
                navigationController?.setViewControllers([profileVC], animated: true)
            } else {
                present(loginAlertController, animated: true, completion: nil)
        }
    }
    
    //MARK: SUBMETHODS
    
    @objc func keyboardShow(_ notification: Notification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            logInScrollView.contentOffset.y = keyboardRectangle.height - (logInScrollView.frame.height - logInButton.frame.maxY) + 16
        }
    }
    
    @objc func keyboardHide(_ notification: Notification){
        logInScrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    @objc func logInButtonAlpha() {
        if loginTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false {
            logInButton.alpha = 1.0
            logInButton.isEnabled = true
        } else {
            logInButton.alpha = 0.5
            logInButton.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
