//
//  FavoriteViewModel.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 13.07.2022.
//

import UIKit
import CoreData

final class CoreDataManager {
        
    // MARK: PROPERTIES

    static let shared = CoreDataManager()
    
    private let persistentContainer: NSPersistentContainer
    private let fetchRequest: NSFetchRequest<FavoritePostEntity>

    private lazy var context = persistentContainer.viewContext
    
    private lazy var saveContext: NSManagedObjectContext = {
        let saveContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        saveContext.persistentStoreCoordinator = self.persistentContainer.persistentStoreCoordinator
        saveContext.mergePolicy = NSOverwriteMergePolicy
        return saveContext
    }()
    
    var fetchedResultsController: NSFetchedResultsController<FavoritePostEntity> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<FavoritePostEntity> = FavoritePostEntity.fetchRequest()
                
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: "Master")
//        aFetchedResultsController.delegate = FavoriteViewController.self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch let error{
            print(error.localizedDescription)
        }
        return _fetchedResultsController!
        
        
    }
    var _fetchedResultsController: NSFetchedResultsController<FavoritePostEntity>? = nil
    
    // MARK: INITS

    private init() {
        let container = NSPersistentContainer(name: "FavoritePostModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        self.persistentContainer = container
        self.fetchRequest = FavoritePostEntity.fetchRequest()

    }
    
    // MARK: METHODS

    func fetchFavourites() -> [Post] {
        
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
        fetchRequest.predicate = nil
        return fetchedPosts
    }
    
    func fetchFiltredFavourites(_ author: String) -> [Post] {
            let predicate = NSPredicate(format: "author = %@", author)
        fetchRequest.predicate = predicate
        return fetchFavourites()
    }
    
    func saveFavourite (post: Post) {

        guard let favoritePosts = fetchedResultsController.fetchedObjects else { return }
        
        if favoritePosts.contains(where: { $0.id == post.personalID }) {
            print("The post is already in the favourites list")
            return
        } else {
            
            let context = self.fetchedResultsController.managedObjectContext
//            saveContext.perform {
                let newFavourite = FavoritePostEntity(context: context)
                newFavourite.title = post.title
                newFavourite.author = post.author
                newFavourite.text = post.description
                newFavourite.likes = Int64(post.likes)
                newFavourite.views = Int64(post.views)
                newFavourite.image =  post.image.pngData()
                newFavourite.id = post.personalID
                
                self.printThread() /// Чтобы понимать, на каком потоке находится функция в момент сохоранения
                
                do {
                    try self.context.save()
                    print("💾 Saved: \(post.title)\nAuthor: \(post.author)")
                } catch let error {
                    print(error.localizedDescription)
                }
//            }
        }
        self.printThread() /// Проверка, данная функция должна вызваться раньше, чем произойдёт сохранение ✅
    }
    
    func deleteFavourite (post: Post) {
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
    
    
    //MARK: CoreData: Remove all data
    
    public func removeFromCoreData() {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavoritePostEntity")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try context.execute(deleteRequest)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
    }
}
// MARK: SUBMETHODS

extension CoreDataManager {
    
    func printThread() {
        if Thread.isMainThread {
            print ("✅ on main thread")
        } else {
            print ("⛔️ off main thread")
        }
    }
}
