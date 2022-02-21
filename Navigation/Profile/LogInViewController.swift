//
//  LogInViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 20.02.2022.
//

import UIKit

struct ColorSet {
    
    static let mainColor = UIColor(named: "main_color")
}

class LogInViewController: UIViewController, UITextFieldDelegate {  // понять UITextFieldDelegate
    
    var isLogin = false
    
    private var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        
        self.loginTextField.delegate = self     // понять
        self.passwordTextField.delegate = self  // понять

        super.viewDidLoad()
        setupContentViews()
        hideKeyboardWhenTappedAround()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        isLogin = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private lazy var loginTextField = logPassTextField(placeholder: "Email or phone", secure: false)
    private lazy var passwordTextField = logPassTextField(placeholder: "Password", secure: true)
    
    private lazy var logInScrollView: UIScrollView = {
        let logInScrollView = UIScrollView()
        logInScrollView.toAutoLayout()
        return logInScrollView
    }()
    
    private lazy var logInHeaderView: UIView = {
        let logInHeaderView = UIView()
        logInHeaderView.toAutoLayout()
        return logInHeaderView
    }()
    
    private lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.toAutoLayout()
        logo.image = UIImage(named: "logo")
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginTextField, passwordTextField])
        stackView.toAutoLayout()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.backgroundColor = .clear
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.distribution = .fillProportionally
        stackView.backgroundColor = .systemGray6
        stackView.clipsToBounds = true
        return stackView
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setTitle("Log in", for: .normal)
        
        button.titleLabel?.textColor = UIColor.white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        if let image = UIImage(named: "blue_pixel") {
            button.setBackgroundImage(image.image(alpha: 1.0), for: .normal)
            button.setBackgroundImage(image.image(alpha: 0.8), for: .selected)
            button.setBackgroundImage(image.image(alpha: 0.8), for: .highlighted)
            button.setBackgroundImage(image.image(alpha: 0.8), for: .disabled)
        }
        
        button.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private func setupContentViews() {
        view.backgroundColor = .white
        view.addSubview(logInScrollView)
        logInScrollView.addSubview(logInHeaderView)
        logInHeaderView.addSubviews(logo, textFieldsStackView, logInButton)
        textFieldsStackView.addArrangedSubview(loginTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        self.bottomConstraint = logInScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        self.bottomConstraint?.isActive = true

        NSLayoutConstraint.activate([
            
            logInScrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            logInScrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            logInScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logInScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            logInHeaderView.leftAnchor.constraint(equalTo: logInScrollView.leftAnchor),
            logInHeaderView.rightAnchor.constraint(equalTo: logInScrollView.rightAnchor),
            logInHeaderView.topAnchor.constraint(equalTo: logInScrollView.topAnchor),
            logInHeaderView.bottomAnchor.constraint(equalTo: logInScrollView.bottomAnchor),
            logInHeaderView.centerXAnchor.constraint(equalTo: logInScrollView.centerXAnchor),
            logInHeaderView.centerYAnchor.constraint(equalTo: logInScrollView.centerYAnchor),
            
            logo.widthAnchor.constraint(equalToConstant: 100),
            logo.heightAnchor.constraint(equalToConstant: 100),
            logo.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            logo.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 120),
            
            textFieldsStackView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            textFieldsStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            textFieldsStackView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 120),
            textFieldsStackView.heightAnchor.constraint(equalToConstant: 100),
            
            logInButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            logInButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            logInButton.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
                        
        ])
    }
    
    //MARK: METHODS
    
    @objc private func logInButtonPressed(sender: UIButton!) {
        
        guard loginTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false else {return}
        isLogin = true
        self.navigationController?.popViewController(animated: true)
        
    }
    
    private func logPassTextField(placeholder: String, secure: Bool) ->  UITextField {
        let logPassTextField = UITextField()
        
        logPassTextField.toAutoLayout()
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

    
    //MARK: Понять
    
    @objc func keyboardShow(_ notification: Notification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            
            self.bottomConstraint?.constant = keyboardRectangle.height + 20
            self.view.layoutIfNeeded()


            print("Keyboard show! \(keyboardRectangle.height)")
        }
    }
    
    
    @objc func keyboardHide(_ notification: Notification){
        
        print("Keyboard Hide!")

        self.bottomConstraint?.constant = 0
        self.view.layoutIfNeeded()

        }
    
//        @objc func keyboardWillShow(notification:NSNotification){
//
//            let userInfo = notification.userInfo!
//            var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
//            keyboardFrame = self.view.convert(keyboardFrame, from: nil)
//
//            var contentInset:UIEdgeInsets = logInScrollView.contentInset
//            contentInset.bottom = keyboardFrame.size.height + 20
//            logInScrollView.contentInset = contentInset
//        }
//
//        @objc func keyboardWillHide(notification:NSNotification){
//            let contentInset:UIEdgeInsets = UIEdgeInsets.zero
//            logInScrollView.contentInset = contentInset
//        }
}

// MARK: Alpha UIImage
extension UIImage {
    func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
