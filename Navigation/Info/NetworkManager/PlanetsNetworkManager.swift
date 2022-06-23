//
//  PlanetsNetworkManager.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 23.06.2022.
//

import Foundation

final class PlanetsNetworkManager {
    
    static let shared = PlanetsNetworkManager()
    
    var planet: PlanetModel?
    
    private let stringURL = "https://swapi.dev/api/planets/1"
    
    public func urlSession() {
        if let url = URL(string: stringURL) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let unwrappedData = data {
                    do {
                        self.planet = try JSONDecoder().decode(PlanetModel.self, from: unwrappedData)
                    }
                    catch let error {
                        print("⛔️ PLANET ERROR: \(error.localizedDescription)")
                    }
                }
            }
            task.resume()
            
        }
    }
}
