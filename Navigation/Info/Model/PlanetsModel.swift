//
//  PlanetsModel.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 23.06.2022.
//

import Foundation

struct PlanetModel: Codable {
    var name: String
    var rotationPeriod: String
    var orbitalPeriod: String
    var diameter: String
    var climate: String
    var gravity: String
    var terrain: String
    var surfaceWater: String
    var population: String
    var residents: [String]
    var films: [String]
    var created: String
    var edited: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
    case name
    case rotationPeriod = "rotation_period"
    case orbitalPeriod = "orbital_period"
    case diameter
    case climate
    case gravity
    case terrain
    case surfaceWater = "surface_water"
    case population
    case residents
    case films
    case created
    case edited
    case url
        
    }
}
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        name = try container.decode(String.self, forKey: .name)
//        rotationPeriod = try container.decode(Int.self, forKey: .rotationPeriod)
//        orbitalPeriod = try container.decode(Int.self, forKey: .orbitalPeriod)
//        diameter = try container.decode(Int.self, forKey: .diameter)
//        climate = try container.decode(String.self, forKey: .climate)
//        gravity = try container.decode(String.self, forKey: .gravity)
//        terrain = try container.decode(String.self, forKey: .terrain)
//        surfaceWater = try container.decode(Int.self, forKey: .surfaceWater)
//        population = try container.decode(Int.self, forKey: .population)
//        residents = try container.decode([String].self, forKey: .residents)
//        films = try container.decode([String].self, forKey: .films)
//        created = try container.decode(String.self, forKey: .created)
//        edited = try container.decode(String.self, forKey: .edited)
//        url = try container.decode(String.self, forKey: .url)

//    }
//}

/*
 {
     "name": "Tatooine",
     "rotation_period": "23",
     "orbital_period": "304",
     "diameter": "10465",
     "climate": "arid",
     "gravity": "1 standard",
     "terrain": "desert",
     "surface_water": "1",
     "population": "200000",
     "residents": [
         "https://swapi.dev/api/people/1/",
         "https://swapi.dev/api/people/2/",
         "https://swapi.dev/api/people/4/",
         "https://swapi.dev/api/people/6/",
         "https://swapi.dev/api/people/7/",
         "https://swapi.dev/api/people/8/",
         "https://swapi.dev/api/people/9/",
         "https://swapi.dev/api/people/11/",
         "https://swapi.dev/api/people/43/",
         "https://swapi.dev/api/people/62/"
     ],
     "films": [
         "https://swapi.dev/api/films/1/",
         "https://swapi.dev/api/films/3/",
         "https://swapi.dev/api/films/4/",
         "https://swapi.dev/api/films/5/",
         "https://swapi.dev/api/films/6/"
     ],
     "created": "2014-12-09T13:50:49.641000Z",
     "edited": "2014-12-20T20:58:18.411000Z",
     "url": "https://swapi.dev/api/planets/1/"
 }
 */
