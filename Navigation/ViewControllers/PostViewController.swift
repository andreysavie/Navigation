//
//  PostViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 11.02.2022.
//

import UIKit

struct Post {
    var title: String
}

class PostViewController: UIViewController {
    
    var post: Post?
    let infoViewController = InfoViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let infoBarButtonItem = UIBarButtonItem(
            title: "Info",
            style: .plain,
            target: self,
            action: #selector(showInfo)
        )
        
        self.navigationItem.rightBarButtonItem  = infoBarButtonItem
        view.backgroundColor = UIColor.lightGray
        
        if let thisPost = post {
            title = thisPost.title
        }
    }
    
    @objc func showInfo() {
        infoViewController.title = title
        present(infoViewController, animated: true, completion: nil)
    }
}

