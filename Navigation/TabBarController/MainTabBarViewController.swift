//
//  AppDelegate.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 12.05.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    private let feedViewController = Factory(navigationController: UINavigationController(), state: .feed)
    
    private let profileViewController = Factory(navigationController: UINavigationController(), state: .profile)

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = UIColor.systemGray5

        setControllers()
    }
    
    private func setControllers() {
        viewControllers = [
            feedViewController.navigationController,
            profileViewController.navigationController
        ]
    }

}
