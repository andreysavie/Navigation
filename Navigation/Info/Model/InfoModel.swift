//
//  Model.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 22.06.2022.
//

import Foundation

public struct InfoModel: Codable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}
