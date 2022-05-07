//
//  FeedViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 10.02.2022.
//


import UIKit
import SnapKit

class FeedViewController: UIViewController {
    
    // MARK: PROPERTIES
    
   private var model = Model()

    
    private lazy var newPostButton: CustomButton = {
        let button = CustomButton (
            title: "New post",
            titleColor: .white,
            backColor: ColorSet.mainColor!,
            backImage: UIImage()
        )
        button.clipsToBounds = false
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowRadius = 5.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.8
        
        return button
    }()
    
    
    private lazy var someTextField: UITextField = {
        
        let textField = UITextField()
        
        textField.layer.cornerRadius = 12
        textField.clipsToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.backgroundColor = .white
        
        textField.placeholder = "Enter your status..."
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        return textField
    }()
    
    private lazy var someButton: CustomButton = {
        let button = CustomButton (
            title: "Send to model",
            titleColor: .white,
            backColor: ColorSet.mainColor!,
            backImage: UIImage()
        )
        return button
    }()
    
    private lazy var someLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.text = "some text..."
        label.textAlignment = .center
        return label
    }()
    
    
    // MARK: INITS
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubviews(newPostButton, someLabel, someTextField, someButton)
        setupFeedLayout()
        
        newPostButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.showNewPostVC()
        }
        
        someButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.someButtonAction()
        }

        // MARK: - Task 6. part 2. Notification center addObserver
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(codeRed),
            name: NSNotification.Name.codeRed,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(codeGreen),
            name: NSNotification.Name.codeGreen,
            object: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: METHODS
    
    // MARK: - Task 6. part 2. Notification center actions

    @objc func codeRed() {
        someLabel.text = "CODE RED"
        someLabel.textColor = .red
    }
    
    @objc func codeGreen() {
        someLabel.text = "CODE GREEN"
        someLabel.textColor = .green
    }
    
    // MARK: - Task 6. part 2. sending textField's text to model
    
    private func someButtonAction() {
        model.check(word: someTextField.text!)
    }
    
    private func setupFeedLayout() {
        newPostButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        someLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(newPostButton.snp.bottom).offset(16)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        someTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(someLabel.snp.bottom).offset(16)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        someButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(someTextField.snp.bottom).offset(16)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }
    
    private func showNewPostVC() {
        let postVC = PostViewController()
        postVC.title = "New post"
        postVC.view.backgroundColor = .systemGray5
        self.navigationController?.pushViewController(postVC, animated: true)
    }
}
