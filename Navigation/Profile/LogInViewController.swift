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

class LogInViewController: UIViewController {
    
    private lazy var logo: UIImageView = {
        
        let logo = UIImageView()
        
        logo.toAutoLayout()
        
        logo.image = UIImage(named: "logo")
        logo.contentMode = .scaleAspectFit

//        logo.clipsToBounds = true
//        logo.layer.cornerRadius = 25
//        logo.layer.borderWidth = 0.5
//        logo.layer.borderColor = UIColor.lightGray.cgColor
        
        return logo
    }()
    
    private lazy var loginTextField = logPassTextField(placeholder: "Email or phone", secure: false)
    private lazy var passwordTextField = logPassTextField(placeholder: "Password", secure: true)

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
//        button.backgroundColor = ColorSet.mainColor
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        if let image = UIImage(named: "blue_pixel") {
            button.setBackgroundImage(image.image(alpha: 1.0), for: .normal)
            button.setBackgroundImage(image.image(alpha: 0.8), for: .selected)
            button.setBackgroundImage(image.image(alpha: 0.8), for: .highlighted)
            button.setBackgroundImage(image.image(alpha: 0.8), for: .disabled)
            
        }
        

//        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        return button
        
    }()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(logo)
        view.addSubview(textFieldsStackView)
        view.addSubview(logInButton)

        setupConstraints()
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([

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
            logInButton.heightAnchor.constraint(equalToConstant: 50)

        ])
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
        logPassTextField.isSecureTextEntry = secure

        return logPassTextField
    }
}


