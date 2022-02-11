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
        let attributes = [NSAttributedString.Key.font: UIFont(name: "American Typewriter", size: 16)]
//        let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "American Typewriter", size: 16)]
//
//        let titleView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 64.0))
//        let titleLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 64.0))
//        titleLabel.text = "FEED"
//
//        titleView.addSubview(titleLabel)
        
        
         
        //VievControllers:
        
        let feedVC = FeedViewController()
        feedVC.view.backgroundColor = .systemGray
        let feedNC = UINavigationController(rootViewController: feedVC)
        
        let profileVC = ProfileViewController()
        profileVC.view.backgroundColor = .brown
        let profileNC = UINavigationController(rootViewController: profileVC)
     
        tabBarController.viewControllers = [feedNC, profileNC]
        
        feedNC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "list.bullet.circle"), selectedImage: UIImage(systemName: "list.bullet.circle.fill"))
        feedNC.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        feedNC.tabBarItem.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
//        feedNC.navigationController?.navigationBar.titleTextAttributes = titleAttributes as [NSAttributedString.Key : Any]
        feedNC.navigationBar.topItem?.title = "FEED"

        
        profileNC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), selectedImage: UIImage(systemName: "person.circle.fill"))
        profileNC.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        profileNC.tabBarItem.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        profileNC.navigationBar.topItem?.title = "PROFILE"

        tabBarController.tabBar.isHidden = false

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}
