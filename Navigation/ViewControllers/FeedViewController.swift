//
//  FeedViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 10.02.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    var postVC = PostViewController()
     
    private lazy var firstPostButton: UIButton = {
        
        let button = UIButton()
                
        button.translatesAutoresizingMaskIntoConstraints = false

        button.setImage(UIImage(named: "post1"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill

        button.backgroundColor = .systemTeal
        
        button.layer.cornerRadius = 4
        
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        
        
        
        button.addTarget(self, action: #selector(showNewPostVC), for: .touchUpInside)
        
        return button
        
    }()

    private lazy var secondPostButton: UIButton = {
        
        let button = UIButton()
                
        button.translatesAutoresizingMaskIntoConstraints = false
        
//        button.setTitle("Second post", for: .normal)
        button.setImage(UIImage(named: "post2"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill

        button.backgroundColor = .systemTeal
        
        button.layer.cornerRadius = 4
        
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        
        button.addTarget(self, action: #selector(showNewPostVC), for: .touchUpInside)
        
        return button
        
    }()
    
    
    private lazy var stackView: UIStackView = {
        
         let stackView = UIStackView(arrangedSubviews: [firstPostButton, secondPostButton])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.backgroundColor = .clear
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(showNewPostVC))
//        stackView.addGestureRecognizer(tap)
//        stackView.isUserInteractionEnabled = true
        
        return stackView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
         
        view.addSubview(stackView)
        setupStackViewConstraints()
        
    }
    
    private func setupStackViewConstraints() {
        
        NSLayoutConstraint.activate([
           
            stackView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: view.bounds.height / 1.5)

        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc func showNewPostVC(sender: UIButton!) {
        
        let post = Post(title: "New post")
        
        postVC.post = post
        postVC.view.backgroundColor = UIColor(displayP3Red: 0.582, green: 0.886, blue: 0.878, alpha: 1.0)
        
        self.navigationController?.pushViewController(postVC, animated: true)
        
        tabBarController?.tabBar.isHidden = true
    }
    
}



