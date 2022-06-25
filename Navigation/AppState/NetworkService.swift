//
//  NetworkService.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 16.06.2022.
//

import Foundation

//MARK: - Задание IOSDT 1.1: Создание NetworkService

struct NetworkService {
        
    static func urlSession(stringURL: String) {
        
        if let url = URL(string: stringURL) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                if error == nil, let data = data, let response = response as? HTTPURLResponse {
                    
                    print("💾 data: \(String(decoding: data, as: UTF8.self))")
                    print("✅ statusCode: \(response.statusCode) ")
                    print("✅ headerFields: \(response.allHeaderFields) ")

                } else if let error = error {
                    print("⛔️ error: \(error.localizedDescription) ")
                    //При выключенном интернете: ⛔️ error: The Internet connection appears to be offline.
                }
            }
            
            task.resume()
        }
    }
}


