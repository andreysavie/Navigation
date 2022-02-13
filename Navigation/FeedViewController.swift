//
//  FeedViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 10.02.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    var postVC = PostViewController()
    
    init() {
        postVC = PostViewController()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleAttributes = [NSAttributedString.Key.font: UIFont(name: "Arial", size: 20) as Any] as [NSAttributedString.Key : Any]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(
            frame: CGRect(
                x: UIScreen.main.bounds.midX - 75,
                y: UIScreen.main.bounds.maxY - 150,
                width: 150,
                height: 50)
        )
        
        button.layer.cornerRadius = button.frame.size.height / 4
        button.backgroundColor = .systemTeal
        button.setTitle("New post", for: .normal)
        button.addTarget(self, action: #selector(showNewPostVC), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    
    @objc func showNewPostVC(sender: UIButton!) {
        
        let post = Post(title: "My first post")
        
        postVC.post = post
        postVC.view.backgroundColor = UIColor(displayP3Red: 0.582, green: 0.886, blue: 0.878, alpha: 1.0)
        
        self.navigationController?.pushViewController(postVC, animated: true)
        
        tabBarController?.tabBar.isHidden = true
    }
}



