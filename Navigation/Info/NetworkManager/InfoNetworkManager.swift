//
//  InfoNetworkManager.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 22.06.2022.
//

import Foundation

final class InfoNetworkManager {
    
    static let shared = InfoNetworkManager()
        
    var infoModel = InfoModel(userId: 1, id: 1, title: "", completed: true)
    
    
    private let stringURL = "https://jsonplaceholder.typicode.com/todos/5"
    
    public func urlSession() {
        if let url = URL(string: stringURL) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                if error == nil, let data = data {
                    
                    do {
                        
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                        if let object = json as? [String: Any] {
                            
                            self.infoModel.userId = object["userId"] as? Int ?? 0
                            self.infoModel.id = object["id"] as? Int ?? 0
                            self.infoModel.title = object["title"] as? String ?? "unknown"
                            self.infoModel.completed = object["completed"] as? Bool ?? false
                            
                            print( "✅\(self.infoModel.title)" )
                            
                        }
                    } catch {
                        print("⛔️\(error.localizedDescription)")
                    }


                } else if let error = error {
                    print("⛔️ error: \(error.localizedDescription) ")
                }
            }
            
            task.resume()
        }
    }
}
