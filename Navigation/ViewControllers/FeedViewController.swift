//
//  FeedViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 10.02.2022.
//


import UIKit

class FeedViewController: UIViewController {
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(
            frame: CGRect(
                x: UIScreen.main.bounds.midX - 75,
                y: UIScreen.main.bounds.midY - 25,
                width: 150,
                height: 50)
        )
        button.setTitle("New post", for: .normal)
        button.backgroundColor = ColorSet.mainColor
        button.layer.cornerRadius = button.frame.size.height / 4
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowRadius = 5.0
        let shadowColor = UIColor.black
        button.layer.shadowColor = shadowColor.cgColor
        button.layer.shadowOpacity = 0.8
        button.addTarget(self, action: #selector(showNewPostVC), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func showNewPostVC(sender: UIButton!) {
        let postVC = PostViewController()
        postVC.title = "New post"
        postVC.view.backgroundColor = .systemGray5
        self.navigationController?.pushViewController(postVC, animated: true)
    }
}


