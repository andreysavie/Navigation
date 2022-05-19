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

        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        let loginVC = LogInViewController()
        let loginNC = UINavigationController(rootViewController: loginVC)
        loginNC.tabBarItem = UITabBarItem(
                        title: "Profile",
                        image: UIImage(systemName: "person.circle"),
                        selectedImage: UIImage(systemName:"person.circle.fill")
                    )
        loginVC.delegate = inspector
        
        DispatchQueue.global().async {
            createPhotosArray()
        }
        
        let mainCoordinator = MainCoordinator()
        window?.rootViewController = mainCoordinator.startApplication()
        window?.makeKeyAndVisible()
        
        return true
    }
}
