//
//  InfoNetworkManager.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 22.06.2022.
//

import Foundation

final class InfoNetworkManager {
    
//MARK: PROPERTIES =======================================================================
    
    static let shared = InfoNetworkManager()
    
    public var infoModel = InfoModel(userId: 1, id: 1, title: "sss", completed: true )
    
    private let stringURL = "https://jsonplaceholder.typicode.com/todos/5"
    
//MARK: METHODS =======================================================================

    public func urlSession() {
        if let url = URL(string: stringURL) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let unwrappedData = data {
                    do {
                        let serializedDictionary = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                        
                        if let object = serializedDictionary as? [String: Any] {
                            self.infoModel.userId = object["userId"] as? Int ?? 0
                            self.infoModel.id = object["id"] as? Int ?? 0
                            self.infoModel.title = object["title"] as? String ?? "unknown"
                            self.infoModel.completed = object["completed"] as? Bool ?? false
                            
                            print("✅\(self.infoModel.userId )")

                        }
                    }
                    catch let error {
                        print("⛔️\(error.localizedDescription)")
                    }
                }
            }
            task.resume()
            
        }
    }
}
