//
//  PostViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 11.02.2022.
//

import UIKit

class PostViewController: UIViewController {
    
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

        view.backgroundColor = UIColor(displayP3Red: 0.130, green: 0.130, blue: 0.130, alpha: 1.0)

    }
    
    override func viewWillAppear(_ animated: Bool) {
                
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidDisappear(_ animated: Bool) {
                
        self.tabBarController?.tabBar.isHidden = false
    }

    
    @objc func showInfo() {
        infoViewController.title = title
        present(infoViewController, animated: true, completion: nil)
    }
}

