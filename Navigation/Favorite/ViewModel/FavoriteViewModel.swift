//
//  FavoriteViewModel.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 13.07.2022.
//

import UIKit
import CoreData

final class FavoriteViewModel {
    
    static let shared = FavoriteViewModel()
    
    public var favoritePosts = [FavoritePostEntity]()
    
    
    //    public var favoritePosts = [
    //
    //    Post(
    //                      title: "«Юрент» вошел в экосистему МТС",
    //                      description: "Сервис проката самокатов «Юрент» привлек более 2 млрд рублей от МТС и фондов VPE Capital и VEB в ходе последнего раунда финансирования. МТС вложила в сервис 740 млн рублей став лид-инвестором, фонд прямых инвестиций VPE Capital — 700 млн руб., венчурный фонд VEB Ventures — 650 млн руб. Об этом сообщает издание Inc.",
    //                      image: "post_3",
    //                      likes: 241,
    //                      views: 54430),
    //    Post(
    //                      title: "Кем пообедал древний крокодил?",
    //                      description: "Австралийские и американские палеонтологи впервые описали окаменелость крокодила, в брюшной полости которого, вот сюрприз, нашлись останки еды, то бишь динозавра. Как показало дальнейшее изучение, ученые имеют дело с ранее неописанным видом крокодиловидного мелового периода, которого они назвали убийцей динозавров — Confractosuchus sauroktonos.",
    //                      image: "post_4",
    //                      likes: 76,
    //                      views: 8965),
    //    Post(
    //                      title: "27 февраля Samsung представит Galaxy Book",
    //                      description: "Издание Verge сообщает, что южнокорейская компания Samsung представит ноутбук Galaxy Book 27 февраля в рамках выставки мобильной индустрии Mobile World Congress. Трансляция мероприятия пройдет Samsung Newsroom и на канале компании в Youtube.",
    //                      image: "post_5",
    //                      likes: 20,
    //                      views: 2420)
    //]
    
    func numberOfRows() -> Int {
        return favoritePosts.count
    }
    
//    func cellViewModel(forIndexPath indexPath: IndexPath) -> FavoritePostTableViewCellViewModel? {
//        let post = favoritePosts[indexPath.row]
//        return FavoritePostTableViewCellViewModel(post: post)
//    }
    
    func save(post: Post) {
        
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
    
    func removeCoreData() {
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
    
    func retrieveValues() {
        favoritePosts.removeAll()
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<FavoritePostEntity>(entityName: "FavoritePostEntity")
            
            
            do {
                let results = try context.fetch(fetchRequest)
                
                for result in results {
                    print (result.title ?? "???")
                    
                    favoritePosts.append(result)
                    
                }
            } catch {
                print ("Could not retrive")
            }
        }
        
        print ("🐸\(favoritePosts.count)") 
    }
    
    
    
    
}
