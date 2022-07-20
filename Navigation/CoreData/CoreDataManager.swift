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
    
    public var favoritePosts = [FavoritePostEntity]()
        
    
    //MARK: Метрод сохранения поста в CoreData
    
    public func saveToCoreData(post: Post) {
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            
            guard let entityDescription = NSEntityDescription.entity(forEntityName: "FavoritePostEntity", in: context) else { return }
            
            let newValue = NSManagedObject(entity: entityDescription, insertInto: context)
            
            let image = UIImage(named: post.image)
            let imageData = image!.pngData()
            
            newValue.setValue(imageData, forKey: "image")
            newValue.setValue(post.title, forKey: "title")
            newValue.setValue(post.description, forKey: "text")
            newValue.setValue(post.likes, forKey: "likes")
            newValue.setValue(post.views, forKey: "views")
            newValue.setValue(post.personalID, forKey: "id")
            
            do {
                try context.save()
                print("Saved: \(post.title)")
            } catch {
                print("Saving Error")
            }
        }
    }
    
    //MARK: Метрод извлечения данных из CoreData

    public func retrieveFromCoreData() {
        favoritePosts.removeAll()
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<FavoritePostEntity>(entityName: "FavoritePostEntity")
            
            do {
                let results = try context.fetch(fetchRequest)
                
                for result in results {
                    favoritePosts.append(result)
                }
            } catch {
                print ("Could not retrive")
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
