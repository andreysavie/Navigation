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

    private init() {
        let container = NSPersistentContainer(name: "FavoritePostModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        self.persistentContainer = container
    }
    
    
    func fetchFavourites() -> [Post] {
        let fetchRequest = FavoritePostEntity.fetchRequest()
        var fetchedPosts = [Post]()
        var favoritePosts = [FavoritePostEntity]()
        do {
            favoritePosts = try context.fetch(fetchRequest)
            for favorite in favoritePosts {
                
                let image = UIImage(data: favorite.image ?? Data()) ?? UIImage()
                
                let post = Post(
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
    
    
    func updateFavourite (post: Post) {
        let favoritePosts = fetchFavourites()
        if favoritePosts.contains(where: { $0.personalID == post.personalID }) {
            print("The post is already in the favourites list")
            return
        } else {
            let newFavourite = FavoritePostEntity(context: context)
            newFavourite.title = post.title
            newFavourite.text = post.description
            newFavourite.likes = Int64(post.likes)
            newFavourite.views = Int64(post.views)
            newFavourite.image =  post.image.pngData()
            newFavourite.id = post.personalID
            
            do {
                try self.context.save()
                print("Saved: \(post.title)")
            } catch let error {
                print(error)
            }
        }
    }
    
    
    //MARK: Метрод удаления всех данных из CoreData
    
    public func removeFromCoreData() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavoritePostEntity")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try context.execute(deleteRequest)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
