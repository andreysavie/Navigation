//
//  AppDelegate.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 10.02.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // MARK: - HW IOSDT 1.3
        FirebaseApp.configure()
                
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let url = AppConfiguration.randomURL()
        
        let mainCoordinator = MainCoordinator()
        
        let loginVC = LogInViewController()
        let loginNC = UINavigationController(rootViewController: loginVC)
        loginNC.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person.circle"),
            selectedImage: UIImage(systemName:"person.circle.fill")
        )

        let loginFactory = MyLoginFactory()
        loginVC.delegate = loginFactory.returnLoginInspector()
        
        DispatchQueue.global().async {
            ContentManager.shared.createPhotosArray()
        }
        
        NetworkService.urlSession(stringURL: url)
        
        InfoNetworkManager.shared.urlSession()
        PlanetsNetworkManager.shared.fetchPlanetsData()
        
        window?.rootViewController = mainCoordinator.startApplication()
        window?.makeKeyAndVisible()
        
        return true
    }
}
