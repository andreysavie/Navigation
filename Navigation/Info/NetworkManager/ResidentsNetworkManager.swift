//
//  ResidentsNetworkManager.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 24.06.2022.
//

import Foundation

final class ResinentsNetworkManager: NSObject {
    
    //MARK: PROPERTIES =======================================================================
    
    static let shared = ResinentsNetworkManager()
    
    public var reloadTableViewData: (() -> ())?
    
    private var isFetched = false
    
    public var residents = [String]()
    
    //MARK: METHODS ==========================================================================

    
    public func fetchResidentsData() {
        guard let planet = PlanetsNetworkManager.shared.planet, isFetched == false else { return }
        
        for residentApiURL in planet.residents {
            if let url = URL(string: residentApiURL) {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    
                    if let unwrappedData = data {
                        do {
                            let serializedDictionary = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                            
                            if let object = serializedDictionary as? [String: Any] {
                                let residentName = object["name"] as? String ?? ""
                                
//                                print("✅\(residentName )")
                                self.residents.append(residentName)
                                self.reloadTableViewData?()
                                self.isFetched = true
                            }
                        }
                        catch let error {
                            print("⛔️ RESIDENTS FETCHING ERROR: \(error.localizedDescription)")
                        }
                    }
                }
                
                task.resume()
            }
        }
    }
}
