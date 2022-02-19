//
//  PostViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 11.02.2022.
//

import UIKit

struct Post {
    
    var title: String
    var image: UIImage
    var label: String

}

class PostViewController: UIViewController {
    
    var post: Post
    
    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    let infoViewController = InfoViewController()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let infoBarButtonItem = UIBarButtonItem(
            title: "Info",
            style: .plain,
            target: self,
            action: #selector(showInfo)
        )
        
        let image = UIImageView(image: post.image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
       
        view.addSubview(image)
        
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        image.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        self.navigationItem.rightBarButtonItem  = infoBarButtonItem
        
        view.backgroundColor = UIColor(displayP3Red: 0.130, green: 0.130, blue: 0.130, alpha: 1.0)
        
        title = post.title
    }
    

    @objc func showInfo() {
        infoViewController.title = title
        present(infoViewController, animated: true, completion: nil)
    }
}

