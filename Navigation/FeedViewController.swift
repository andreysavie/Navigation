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
    
    let titleAttributes = [NSAttributedString.Key.font: UIFont(name: "American Typewriter", size: 20) as Any] as [NSAttributedString.Key : Any]

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.midX - 50, y: UIScreen.main.bounds.midY - 25, width: 100, height: 50))
          button.backgroundColor = .systemGreen
        button.setTitle("New post", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
          self.view.addSubview(button)
        }
    

    @objc func buttonAction(sender: UIButton!) {
          
        let post = Post(title: "My first post!")
        
        postVC.view.backgroundColor = .red
        let postNC = UINavigationController(rootViewController: postVC)
        
        postNC.navigationBar.titleTextAttributes = titleAttributes
        postNC.navigationBar.topItem?.title = post.title

        self.navigationController?.pushViewController(postVC, animated: true)
        
        print("Button tapped")
        
        
        
        }
    }
    
    

