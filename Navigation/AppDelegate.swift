//
//  AppDelegate.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 10.02.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        
        let tabBarController = UITabBarController()

        // MARK: Label styles
                
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
                
         
        // MARK: VievControllers
        
        let feedVC = FeedViewController()
        feedVC.view.backgroundColor = .secondarySystemGroupedBackground
        let feedNC = UINavigationController(rootViewController: feedVC)
        
        let profileVC = ProfileViewController()
        profileVC.view.backgroundColor = .systemGray3
        let profileNC = UINavigationController(rootViewController: profileVC)


        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemGray5
                
        feedNC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "list.bullet.circle"), selectedImage: UIImage(systemName: "list.bullet.circle.fill"))
        feedNC.tabBarItem.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any],for: .normal)
        feedNC.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        feedNC.navigationBar.topItem?.title = "Feed"
        feedNC.navigationBar.barTintColor = UIColor.systemGray5
        feedNC.navigationBar.standardAppearance = appearance
        feedNC.navigationBar.scrollEdgeAppearance = feedNC.navigationBar.standardAppearance
        
        profileNC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), selectedImage: UIImage(systemName:"person.circle.fill"))
        profileNC.tabBarItem.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        profileNC.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        profileNC.navigationBar.topItem?.title = "Profile"
        profileNC.navigationBar.barTintColor = UIColor.systemGray5
        profileNC.navigationBar.standardAppearance = appearance
        profileNC.navigationBar.scrollEdgeAppearance = profileNC.navigationBar.standardAppearance

        tabBarController.viewControllers = [feedNC, profileNC]
        tabBarController.tabBar.backgroundColor = UIColor.systemGray5
        tabBarController.tabBar.layer.borderWidth = 1
        tabBarController.tabBar.layer.borderColor = UIColor.gray.cgColor
                        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}
