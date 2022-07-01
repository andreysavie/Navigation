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
    private let loginViewController = Factory(navigationController: UINavigationController(), state: .login)
    private let musicViewController = Factory(navigationController: UINavigationController(), state: .music)
    private let videoViewController = Factory(navigationController: UINavigationController(), state: .video)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = UIColor.systemGray5

        setControllers()
    }
    
    private func setControllers() {
        viewControllers = [
            loginViewController.navigationController,
            feedViewController.navigationController,
            musicViewController.navigationController,
            videoViewController.navigationController
        ]
    }

}
