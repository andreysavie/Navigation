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
    
    // убрать вниз!
    
//    func showModalLoginVC() {
//        let loginViewController = Factory(navigationController: UINavigationController(), state: .login)
//        loginViewController.navigationController.modalPresentationStyle = .fullScreen
//        self.window?.rootViewController?.present(loginViewController.navigationController, animated: true, completion: nil)
//    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
            
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let url = AppConfiguration.randomURL()
        
        let mainCoordinator = MainCoordinator()
        let inspector = MyLoginFactory.shared.returnLoginInspector()
        
        let loginVC = LogInViewController()
        let loginNC = UINavigationController(rootViewController: loginVC)
        loginNC.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person.circle"),
            selectedImage: UIImage(systemName:"person.circle.fill")
        )
        
        loginVC.delegate = inspector

        DispatchQueue.global().async {
            ContentManager.shared.createPhotosArray()
        }
        NetworkService.urlSession(stringURL: url)
        
        // MARK: - HW IOSDT 1.2 task 1
        InfoNetworkManager.shared.urlSession()
        PlanetsNetworkManager.shared.fetchPlanetsData()
        
        window?.rootViewController = mainCoordinator.startApplication()
        window?.makeKeyAndVisible()
        
        return true
    }
}
