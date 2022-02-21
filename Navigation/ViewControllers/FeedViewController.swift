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
    
    // MARK: Buttons of the posts
    
//    private lazy var firstPostButton = postButton(title: "Coffee", imgName: "post1")
//    private lazy var secondPostButton = postButton(title: "Marry christmas!", imgName: "post2")
    
    // MARK: StackView for posts

//    private lazy var stackView: UIStackView = {
//
//         let stackView = UIStackView(arrangedSubviews: [firstPostButton, secondPostButton])
//
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//
//        stackView.axis = .vertical
//        stackView.distribution = .fillEqually
//        stackView.spacing = 10
//        stackView.alignment = .fill
//        stackView.backgroundColor = .clear
//
//        return stackView
//
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
         
//        view.addSubview(stackView)
//        setupStackViewConstraints()
        
    }
    
    // MARK: Constraints
    
//    private func setupStackViewConstraints() {
//        
//        NSLayoutConstraint.activate([
//           
//            stackView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
//            stackView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
//            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -16),
//            stackView.heightAnchor.constraint(equalToConstant: view.bounds.height / 1.5)
//
//        ])
//    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Button for new post controller opening

//    @objc func showNewPostVC(sender: UIButton!) {
//
//        let postVC = PostViewController(post: Post(title: sender.title(for: .normal)!,
//                                                              image: sender.image(for: .normal)!,
//                                                              label: postLabels[sender.tag]))
//
//        self.navigationController?.pushViewController(postVC, animated: true)
//
//        tabBarController?.tabBar.isHidden = true
//    }
    
//    private func postButton(title: String, imgName: String) -> UIButton {
//
//        let button = UIButton()
//
//        button.translatesAutoresizingMaskIntoConstraints = false
//
//        button.setTitle(title, for: .normal)
//        button.setImage(UIImage(named: imgName), for: .normal)
//        button.imageView?.contentMode = .scaleAspectFill
//
//        button.layer.cornerRadius = 12
//        button.clipsToBounds = true
//
//        button.tag = 0
//
//        button.addTarget(self, action: #selector(showNewPostVC), for: .touchUpInside)
//
//        return button
//
//    }

}

    




