//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 12.05.2022.
//

import UIKit

final class ProfileCoordinator {
    func start(coordinator: ProfileCoordinator) -> UIViewController {
        let viewModel = Model()
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
