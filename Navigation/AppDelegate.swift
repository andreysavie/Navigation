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
        
        //VievControllers:
        
        let feedVC = FeedViewController()
        feedVC.view.backgroundColor = .systemGray
        let feedNC = UINavigationController(rootViewController: feedVC)
        
        let profileVC = ProfileViewController()
        profileVC.view.backgroundColor = .brown
        let profileNC = UINavigationController(rootViewController: profileVC)
     
        tabBarController.viewControllers = [feedNC, profileNC]
        
        feedNC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "list.bullet.circle"), selectedImage: UIImage(named: "list.bullet.circle.fill"))
        feedNC.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        profileNC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "person.circle"), selectedImage: UIImage(named: "person.circle.fill"))
        profileNC.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}
