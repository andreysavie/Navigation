//
//  PlanetsNetworkManager.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 23.06.2022.
//

import Foundation

final class PlanetsNetworkManager {
    
    //MARK: PROPERTIES =======================================================================

    static let shared = PlanetsNetworkManager()
    
    private var isFetched = false
    private let stringURL = "https://swapi.dev/api/planets/1"
    
    public var planet: PlanetModel?
    

    
//    public var planet: PlanetModel? {
//        didSet {
//            ResinentsNetworkManager.shared.fetchResidentsData()
//        }
//    }
    
    //MARK: METHODS =======================================================================

    func fetchPlanetsData() {
        guard isFetched == false else { return }
        
        if let url = URL(string: stringURL) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let unwrappedData = data {
                    do {
                        self.planet = try JSONDecoder().decode(PlanetModel.self, from: unwrappedData)
                        self.isFetched = true
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



