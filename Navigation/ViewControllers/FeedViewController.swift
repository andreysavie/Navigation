//
//  FeedViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 10.02.2022.
//

import UIKit
    
class FeedViewController: UIViewController {
        
    // i will need this labels just later...
    var postLabels = ["Would you like some coffee?", "Last christmas i gave you my heart..."]
    
    private lazy var firstPostButton: UIButton = {
        
        let button = UIButton()
                
        button.translatesAutoresizingMaskIntoConstraints = false

        button.setTitle("Coffee", for: .normal)
        button.setImage(UIImage(named: "post1"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        
        button.backgroundColor = .systemTeal
        
        button.layer.cornerRadius = 4
        
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        
        button.tag = 0

        button.addTarget(self, action: #selector(showNewPostVC), for: .touchUpInside)
        
        return button
        
    }()

    private lazy var secondPostButton: UIButton = {
        
        let button = UIButton()
                
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Last christmas", for: .normal)
        button.setImage(UIImage(named: "post2"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill

        button.backgroundColor = .systemTeal
        
        button.layer.cornerRadius = 4
        
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        
        button.tag = 1
        
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

       
        let postVC = PostViewController(post: Post(title: sender.title(for: .normal)!,
                                                              image: sender.image(for: .normal)!,
                                                              label: postLabels[sender.tag]))
        
        self.navigationController?.pushViewController(postVC, animated: true)

        
//        postVC.view.backgroundColor = UIColor(displayP3Red: 0.130, green: 0.130, blue: 0.130, alpha: 1.0)
//
//        self.navigationController?.pushViewController(postVC, animated: true)
        
        tabBarController?.tabBar.isHidden = true
    }
}
    




