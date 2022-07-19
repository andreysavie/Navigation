//
//  AppDelegate.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 10.02.2022.
//

import UIKit
import FirebaseCoreInternal
import FirebaseCore
import FirebaseAuth
import CoreData


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    let inspector = MyLoginFactory.shared.returnLoginInspector()
    	
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FavoriteViewModel.shared.retrieveValues()

        
//         MARK: - HW IOSDT 1.3
        FirebaseApp.configure()
                
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let url = AppConfiguration.randomURL()
        
        let mainCoordinator = MainCoordinator()        
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
    
    lazy var persistentContainer: NSPersistentContainer = {
        
            let container = NSPersistentContainer(name: "FavoritePostModel")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
        
        // MARK: - Core Data Saving support
        
        func saveContext () {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
}
