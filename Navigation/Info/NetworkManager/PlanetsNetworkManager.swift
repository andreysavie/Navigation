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
    var resident = ResidentModel(name: "")
    var residents = [ResidentModel]()
    
    private let queue = DispatchQueue(label: "planets queue")
    private let stringURL = "https://swapi.dev/api/planets/1"

    private lazy var planetsWorkItem = DispatchWorkItem {
        self.fetchPlanetsData()
    }
    
    private lazy var residentsWorkItem = DispatchWorkItem {
        self.fetchResidentsData()
    }
    
    // MARK: - QUEUES
    
    func fetchData() {
        queue.async(execute: planetsWorkItem)
        planetsWorkItem.notify (queue: queue) {
            self.queue.asyncAfter(deadline: .now() + 1, execute: self.residentsWorkItem)
        }
    }
    
    // MARK: Fetching methods
    
    private func fetchPlanetsData() {
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
    
    
    public func fetchResidentsData() {
        
        guard let planet = self.planet else { return }
        
        for residentApiURL in planet.residents {
            if let url = URL(string: residentApiURL) {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    
                    if let unwrappedData = data {
                        do {
                            let serializedDictionary = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                            
                            if let object = serializedDictionary as? [String: Any] {
                                self.resident.name = object["name"] as? String ?? "psina"
                                
                                print("✅\(self.resident.name )")
                                self.residents.append(self.resident)
                                
                            }
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
}



