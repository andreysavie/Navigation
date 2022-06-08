//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 12.05.2022.
//

import UIKit

final class FeedCoordinator {
    func showDetail(coordinator: FeedCoordinator) -> UIViewController {
        let viewModel = FeedViewModel()
        let viewController = FeedViewController(model: viewModel, coordinator: coordinator)
        viewController.view.backgroundColor = .secondarySystemGroupedBackground
        viewController.title = "Feed"
        return viewController
    }
}


final class NewPostCoordinator {
    func showDetail(navCon: UINavigationController?, coordinator: NewPostCoordinator) {
        let viewModel = NewPostViewModel()
        let viewController = NewPostViewController(viewModel: viewModel, coordinator: coordinator)
        viewController.view.backgroundColor = .systemGray5
        viewController.title = "New post"
        navCon?.pushViewController(viewController, animated: true)
    }
}

final class InfoCoordinator {
    func showDetail(navCon: UINavigationController?, coordinator: InfoCoordinator) {
        let viewModel = InfoViewModel()
        let viewController = InfoViewController(viewModel: viewModel, coordinator: coordinator)
        viewController.title = "information"
        viewController.view.backgroundColor = UIColor(displayP3Red: 0.130, green: 0.130, blue: 0.130, alpha: 1)
        navCon?.present(viewController, animated: true, completion: nil)
    }
}
