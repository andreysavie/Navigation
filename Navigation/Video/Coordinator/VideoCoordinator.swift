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
        viewController.title = "Video"
        return viewController
    }
}

final class VideoPlayerCoordinator {
    func showDetail(navCon: UINavigationController?, coordinator: VideoPlayerCoordinator, key: String) {
        let viewController = VidePlayerViewController(videoKey: key)
        viewController.view.backgroundColor = .systemGray5
        viewController.title = VideoViewModel.videos[key]
        navCon?.pushViewController(viewController, animated: true)
    }
}
