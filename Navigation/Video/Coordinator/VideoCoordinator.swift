//
//  VideoCoordinator.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 11.06.2022.
//

import UIKit

final class VideoCoordinator {
    func showDetail(coordinator: VideoCoordinator) -> UIViewController {
        let viewModel = VideoViewModel()
        let viewController = VideoViewController(model: viewModel, coordinator: coordinator)
        viewController.view.backgroundColor = .secondarySystemGroupedBackground
        viewController.title = "Music"
        return viewController
    }
}
