//
//  FavoriteCoordinator.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 13.07.2022.
//

import UIKit

final class FavoriteCoordinator {
    func showDetail(coordinator: FavoriteCoordinator) -> UIViewController {
        let viewModel = CoreDataManager()
        let viewController = FavoriteViewController(model: viewModel, coordinator: coordinator)
        viewController.view.backgroundColor = .secondarySystemGroupedBackground
        viewController.title = "Favorite posts"
        return viewController
    }
}
