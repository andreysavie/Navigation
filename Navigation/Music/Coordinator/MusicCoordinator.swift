//
//  MusicCoordinator.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 11.06.2022.
//

import UIKit

final class MusicCoordinator {
    func showDetail(coordinator: MusicCoordinator) -> UIViewController {
        let viewModel = MusicViewModel()
        let viewController = MusicViewController(model: viewModel, coordinator: coordinator)
        viewController.view.backgroundColor = .secondarySystemGroupedBackground
        viewController.title = "Music"
        return viewController
    }
}
