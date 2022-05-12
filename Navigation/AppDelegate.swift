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
        
        let inspector = MyLoginFactory.shared.returnLoginInspector()
//        let tabBarController = UITabBarController()

        window = UIWindow(frame: UIScreen.main.bounds)
        
        // MARK: appearance & styles
                
//            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
//
//            let appearance = UINavigationBarAppearance()
//            appearance.configureWithOpaqueBackground()
//            appearance.backgroundColor = UIColor.systemGray5
                
        // MARK: VievControllers
        
//        let feedVC = FeedViewController()
//        feedVC.view.backgroundColor = .secondarySystemGroupedBackground
//        let feedNC = UINavigationController(rootViewController: feedVC)
//        feedNC.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
//        feedNC.navigationBar.topItem?.title = "Feed"
//        feedNC.navigationBar.barTintColor = UIColor.systemGray5
//        feedNC.navigationBar.standardAppearance = appearance
//        feedNC.navigationBar.scrollEdgeAppearance = feedNC.navigationBar.standardAppearance
//        feedNC.tabBarItem = UITabBarItem(
//            title: "Feed",
//            image: UIImage(systemName: "list.bullet.circle"),
//            selectedImage: UIImage(systemName: "list.bullet.circle.fill")
//        )
//        feedNC.tabBarItem.setTitleTextAttributes(attributes,for: .normal)


//        let profileVC = ProfileViewController(userService: TestUserService() as UserService, name: "testname")
//        profileVC.view.backgroundColor = .systemGray3
//        let profileNC = UINavigationController(rootViewController: profileVC)
//        profileNC.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
//        profileNC.navigationBar.topItem?.title = "Profile"
//        profileNC.navigationBar.barTintColor = UIColor.systemGray5
//        profileNC.navigationBar.standardAppearance = appearance
//        profileNC.navigationBar.scrollEdgeAppearance = profileNC.navigationBar.standardAppearance
//        profileVC.tabBarItem = UITabBarItem(
//            title: "Profile",
//            image: UIImage(systemName: "person.circle"),
//            selectedImage: UIImage(systemName:"person.circle.fill")
//        )
//        profileNC.tabBarItem.setTitleTextAttributes(attributes, for: .normal)

        
        let loginVC = LogInViewController()
        let loginNC = UINavigationController(rootViewController: loginVC)
        loginNC.tabBarItem = UITabBarItem(
                        title: "Profile",
                        image: UIImage(systemName: "person.circle"),
                        selectedImage: UIImage(systemName:"person.circle.fill")
                    )
        loginVC.delegate = inspector

//        tabBarController.viewControllers = [feedNC, loginNC]
//        tabBarController.tabBar.backgroundColor = UIColor.systemGray5
        
        createPhotosArray()
        
        let mainCoordinator: Coordinator = MainCoordinator()
        window?.rootViewController = mainCoordinator.startApplication()
        window?.makeKeyAndVisible()
        
        return true
    }
}
