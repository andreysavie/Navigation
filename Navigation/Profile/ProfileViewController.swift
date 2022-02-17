//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 10.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    let header = ProfileHeaderView ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(header)
        self.title = "Profile"
        view.backgroundColor = UIColor.lightGray
        
    }
    
    override func viewWillLayoutSubviews() {
        
        header.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
        
    }
}
