//
//  FavoriteViewModel.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 13.07.2022.
//

import UIKit
import CoreData

final class CoreDataManager {
        
    static let shared = CoreDataManager()
    
    private let persistentContainer: NSPersistentContainer
    
    private lazy var context = persistentContainer.viewContext
    
    private lazy var saveContext: NSManagedObjectContext = {
        let saveContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        saveContext.persistentStoreCoordinator = self.persistentContainer.persistentStoreCoordinator
        saveContext.mergePolicy = NSOverwriteMergePolicy
        return saveContext
    }()
    
//    lazy var saveContext: NSManagedObjectContext = {
//        let masterContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
////        masterContext.parent = self.mainContext
//        masterContext.mergePolicy = NSOverwriteMergePolicy
//        return masterContext
//    }()
    
    private lazy var mainContext: NSManagedObjectContext = {
        let mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.parent = self.masterContext
        mainContext.mergePolicy = NSOverwriteMergePolicy
        return mainContext
    }()
    
     lazy var masterContext: NSManagedObjectContext = {
        let masterContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        masterContext.persistentStoreCoordinator = self.persistentContainer.persistentStoreCoordinator
        masterContext.mergePolicy = NSOverwriteMergePolicy
        return masterContext
    }()
    

    private init() {
        let container = NSPersistentContainer(name: "FavoritePostModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        self.persistentContainer = container

    }
        
    private let mainQueue = DispatchQueue.main
    
    
    func fetchFavourites() -> [Post] {
        let fetchRequest = FavoritePostEntity.fetchRequest()
        var fetchedPosts = [Post]()
        var favoritePosts = [FavoritePostEntity]()
        
        do {
            favoritePosts = try context.fetch(fetchRequest)
            for favorite in favoritePosts {
                
                let image = UIImage(data: favorite.image ?? Data()) ?? UIImage()
                
                let post = Post(
                    author: favorite.author ?? "",
                    title: favorite.title ?? "",
                    description: favorite.text ?? "",
                    image: image,
                    likes: Int(favorite.likes),
                    views: Int(favorite.views),
                    personalID: favorite.id ?? "")
                fetchedPosts.append(post)
            }
        } catch let error {
            print(error)
        }
        return fetchedPosts
    }
    
    
    func printThread() {
        if Thread.isMainThread {
            print ("✅ on main thread")
        } else {
            print ("⛔️ off main thread")
        }
    }
    
    
    
    func saveFavourite (post: Post) {

        let favoritePosts = fetchFavourites()
        if favoritePosts.contains(where: { $0.personalID == post.personalID }) {
            print("The post is already in the favourites list")
            return
        } else {
            
            saveContext.perform {
                let newFavourite = FavoritePostEntity(context: self.saveContext)
                newFavourite.title = post.title
                newFavourite.author = post.author
                newFavourite.text = post.description
                newFavourite.likes = Int64(post.likes)
                newFavourite.views = Int64(post.views)
                newFavourite.image =  post.image.pngData()
                newFavourite.id = post.personalID
                
                self.printThread() /// Чтобы понимать, на каком потоке находится функция в момент сохоранения
                
                do {
                    try self.saveContext.save()
                    print("💾 Saved: \(post.title)\nAuthor: \(post.author)")
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        self.printThread() /// Проверка, данная функция должна вызваться раньше, чем произойдёт сохранение ✅
    }
    
    func deleteFavourite (post: Post) {
        let fetchRequest = FavoritePostEntity.fetchRequest()
        //        var fetchedPosts = [Post]()
        var favoritePosts = [FavoritePostEntity]()
        
        do {
            favoritePosts = try saveContext.fetch(fetchRequest)
                    
            saveContext.perform {
                        for favorite in favoritePosts {
                            if post.personalID == favorite.id {
                                
                                self.printThread() /// Чтобы понимать, на каком потоке находится функция в момент сохоранения

                        self.saveContext.delete(favorite)

                                
                        do {
                            try self.saveContext.save()
                            print("Deleted: \(post.title)")
                        } catch let error {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        } catch let error {
            print(error.localizedDescription)
        }
        
        self.printThread() /// Чтобы понимать, на каком потоке находится функция в момент сохоранения

    }
    
    
    //MARK: Метод удаления всех данных из CoreData
    
    public func removeFromCoreData() {
//        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            
//            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavoritePostEntity")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try context.execute(deleteRequest)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
//        }
    }
}
