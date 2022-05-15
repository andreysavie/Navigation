//
//  TableViewModelType.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 14.05.2022.
//

import Foundation

// MARK: Model type of tableView

protocol PostTableViewViewModelType {
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> PostTableViewCellViewModelType?
}
