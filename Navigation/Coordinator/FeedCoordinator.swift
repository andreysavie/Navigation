//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 12.05.2022.
//

import UIKit

final class FeedCoordinator {
    func start(coordinator: FeedCoordinator) -> UIViewController {
        let viewModel = Model()
        let viewController = FeedViewController(model: viewModel, coordinator: coordinator)
        viewController.view.backgroundColor = .secondarySystemGroupedBackground
        viewController.title = "Feed"
        return viewController
    }
}
