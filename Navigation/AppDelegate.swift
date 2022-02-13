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
        let titleAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 20) as Any] as [NSAttributedString.Key : Any]
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 16)]
        
        let postTitleView = UIView(
            frame: CGRect(
                    x: 0.0,
                    y: 0.0,
                    width: 40.0,
                    height: 64.0)
        )
        
        let postTitleLabel = UILabel(
            frame: CGRect(
                    x: 0.0,
                    y: 0.0,
                    width: 40.0,
                    height: 64.0)
        )
        
        postTitleLabel.text = "NEW POST"

        postTitleView.addSubview(postTitleLabel)
        
        
         
        //VievControllers:
        
        let feedVC = FeedViewController()
        feedVC.view.backgroundColor = .secondarySystemGroupedBackground
        let feedNC = UINavigationController(rootViewController: feedVC)
        
        let profileVC = ProfileViewController()
        profileVC.view.backgroundColor = UIColor(displayP3Red: 0.734, green: 0.780, blue: 0.480, alpha: 1.0)
        let profileNC = UINavigationController(rootViewController: profileVC)
        
        tabBarController.viewControllers = [feedNC, profileNC]
        
        feedNC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "list.bullet.circle"), selectedImage: UIImage(systemName: "list.bullet.circle.fill"))
        feedNC.tabBarItem.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)

        feedNC.navigationBar.titleTextAttributes = titleAttributes
        feedNC.navigationBar.topItem?.title = "FEED"

        
        profileNC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), selectedImage: UIImage(systemName: "person.circle.fill"))
        profileNC.tabBarItem.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        
        profileNC.navigationBar.titleTextAttributes = titleAttributes
        profileNC.navigationBar.topItem?.title = "PROFILE"

        tabBarController.tabBar.isHidden = false

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}
