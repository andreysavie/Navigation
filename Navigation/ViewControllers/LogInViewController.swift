//
//  LogInViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 20.02.2022.
//

import UIKit
import SnapKit
import FirebaseAuth
//import RealmSwift

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: PROPERTIES ======================================================================
    
   public var delegate: LoginViewControllerDelegate?

    var userService = TestUserService()
            
    private var isUserExists: Bool? {
        willSet {
            if newValue! {
                enterButton.setTitle("Log in", for: .normal)
                variableButton.setTitle("Don't have an account? Register", for: .normal)

            } else {
                enterButton.setTitle("Register", for: .normal)
                variableButton.setTitle("Already registred? Log in", for: .normal)
            }
        }
    }
    
    private lazy var logInScrollView = UIScrollView()
    private lazy var contentView = UIView()
    
    private lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginTextField, passwordTextField])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = .systemGray6
        stackView.clipsToBounds = true
        return stackView
    }()
    
    private lazy var enterButton: CustomButton = {
        let button = CustomButton (
            titleColor: UIColor.white,
            backColor: UIColor.white,
            backImage: UIImage(named: "blue_pixel") ?? UIImage()
        )
        
        button.alpha = 0.5
        button.isEnabled = false

        return button
    }()
    
    private lazy var variableButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.setTitleColor(ColorSet.mainColor, for: .normal)
        button.addTarget(self, action: #selector(switchLogin), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginTextField = CustomTextfield (
        customPlaceholder: "Email or phone",
        secure: false,
        iconName: "person"
    )
    
    private lazy var passwordTextField = CustomTextfield (
        customPlaceholder: "Password",
        secure: true,
        iconName: "lock"
    )


    // MARK: INITS ======================================================================

    override func viewDidLoad() {
        super.viewDidLoad()
                
        isUserExists = true
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
//        do { try Auth.auth().signOut() } catch { print (error.localizedDescription) }

                
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                self.pushProfileViewController()
            }
        }
                        
        enterButton.tapAction = { [weak self] in
            guard let self = self else { return }
                self.enterButtonPressed()
            }
        
        loginTextField.textChangedAction = { [weak self] in
            guard let self = self else { return }
                self.enterButtonEnabled()
            }
        
        passwordTextField.textChangedAction = { [weak self] in
            guard let self = self else { return }
                self.enterButtonEnabled()
            }
        
        UserValidation.shared.completion = { [weak self] message in
            guard let self = self else { return }
            self.present(self.showAlertController(message) , animated: true, completion: nil)
        }
        
        setupLayout()
        hideKeyboardWhenTappedAround()
        
    }
        
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

    
    // MARK: METHODS
        
    private func enterButtonPressed() {
        
        guard let login = loginTextField.text, let password = passwordTextField.text else { return }
    
        toAuthentication(login, password)
    }
    
    private func toAuthentication (_ login: String, _ password: String) {
        guard let delegate = self.delegate else { return }

        DispatchQueue.main.async {
            delegate.signing(
                signType: self.isUserExists! ? .signIn : .signUp,
                log: login,
                pass: password
            )
        }
    }


    private func showAlertController(_ description: String) -> UIAlertController {
        let alertController = UIAlertController(
            title: "⚠️ Error! ⚠️",
            message: description,
            preferredStyle: .alert)
        
        let acceptAction = UIAlertAction(title: "OK", style: .default) { _ in }
        
        alertController.addAction(acceptAction)
        return alertController
    }
    
 
    // MARK: LAYOUT

    private func setupLayout() {
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .white
        view.addSubview(logInScrollView)
        logInScrollView.addSubview(contentView)
        contentView.addSubviews(logo, textFieldsStackView, enterButton, variableButton)
        textFieldsStackView.addArrangedSubview(loginTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        
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
        
        enterButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldsStackView.snp.bottom).offset(Constants.margin)
            make.leading.trailing.equalTo(contentView).inset(Constants.margin)
            make.height.equalTo(50)
        }
        
        variableButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView).inset(Constants.margin)
            make.top.equalTo(enterButton.snp.bottom).offset(Constants.margin / 2)
            make.height.equalTo(20)
        }
    }
    
    //MARK: SUBMETHODS
    
    @objc
    private func switchLogin() {
        isUserExists!.toggle()
    }
    
    @objc
    private func keyboardShow(_ notification: Notification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            logInScrollView.contentOffset.y = keyboardRectangle.height - (logInScrollView.frame.height - enterButton.frame.maxY) + 16
        }
    }
    
    @objc
    private func keyboardHide(_ notification: Notification){
        logInScrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    @objc
    private func enterButtonEnabled() {
        if loginTextField.text?.isEmpty == false && passwordTextField.text!.count >= 6 {
            enterButton.alpha = 1.0
            enterButton.isEnabled = true
        } else {
            enterButton.alpha = 0.5
            enterButton.isEnabled = false
        }
    }
    
    private func pushProfileViewController() {
        let coordinator = ProfileCoordinator()
        let profileViewController = coordinator.showDetail(coordinator: coordinator)
        navigationController?.pushViewController(profileViewController, animated: true)
        navigationController?.setViewControllers([profileViewController], animated: true)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

fileprivate extension UITextField {
    private func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    private func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
