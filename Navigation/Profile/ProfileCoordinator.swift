//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 12.05.2022.
//

import UIKit

final class ProfileCoordinator {
    func showDetail(coordinator: ProfileCoordinator) -> UIViewController {
        let viewModel = ProfileViewModel()
        let viewController = ProfileViewController(
            userService: TestUserService() as UserService,
            name: "testname",
            model: viewModel,
            coordinator: coordinator)
        viewController.view.backgroundColor = .systemGray3
        viewController.title = "Profile"
        return viewController
    }
}

final class PhotosCoordinator {
    func showDetail(navCon: UINavigationController?, coordinator: PhotosCoordinator) {
        let viewModel = PhotosViewModel()
        let viewController = PhotosViewController(coordinator: coordinator, viewModel: viewModel)
        viewController.view.backgroundColor = .white
        viewController.title = "Photo Gallery"
        navCon?.tabBarController?.tabBar.isHidden = true
        navCon?.pushViewController(viewController, animated: true)
    }
    
    func pop(navCon: UINavigationController?) {
        navCon?.popViewController(animated: true)
    }
}
