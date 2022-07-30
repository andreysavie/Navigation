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
        
    var fetchedResultsController: NSFetchedResultsController<FavoritePostEntity> {
        
        let fetchRequest: NSFetchRequest<FavoritePostEntity> = FavoritePostEntity.fetchRequest()
                
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.context, sectionNameKeyPath: nil, cacheName: "Master")
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error{
            print(error.localizedDescription)
        }
        return fetchedResultsController
    }
        
    // MARK: METHODS
    
   public func saveFavourite (post: Post) {

        guard let favoritePosts = fetchedResultsController.fetchedObjects else { return }
        
        if favoritePosts.contains(where: { $0.id == post.personalID }) {
            print("The post is already in the favourites list")
            return
        } else {
            
            let context = self.fetchedResultsController.managedObjectContext
                let newFavourite = FavoritePostEntity(context: context)
                newFavourite.title = post.title
                newFavourite.author = post.author
                newFavourite.text = post.description
                newFavourite.likes = Int64(post.likes)
                newFavourite.views = Int64(post.views)
                newFavourite.image =  post.image.pngData()
                newFavourite.id = post.personalID
            
            CoreDataStack.shared.saveContext()
        }
    }
}
