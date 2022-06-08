//
//  Factory.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 25.04.2022.
//

import UIKit

final class Factory {
    
    enum State {
        case feed
        case profile
//        case photos
    }

    let navigationController: UINavigationController
    let state: State
    
    init(
        navigationController: UINavigationController,
        state: State
    ) {
        self.navigationController = navigationController
        self.state = state
        startModule()
    }
    
    func startModule() {
        switch state {
        case .feed:
            let coordinator = FeedCoordinator()
            let feedViewController = coordinator.showDetail(coordinator: coordinator)

            navigationController.setViewControllers([feedViewController], animated: true)
            navigationController.navigationBar.barTintColor = UIColor.systemGray5
            navigationController.navigationBar.standardAppearance = Constants.navigationBarAppearance
            navigationController.tabBarItem.setTitleTextAttributes(Constants.attributes,for: .normal)
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
            navigationController.tabBarItem = UITabBarItem(
                title: "Feed",
                image: UIImage(systemName: "list.bullet.circle"),
                selectedImage: UIImage(systemName: "list.bullet.circle.fill")
            )

        case .profile:
            let coordinator = ProfileCoordinator()
            let profileViewController = coordinator.showDetail(coordinator: coordinator)

            navigationController.setViewControllers([profileViewController], animated: true)
            navigationController.navigationBar.barTintColor = UIColor.systemGray5
            navigationController.navigationBar.standardAppearance = Constants.navigationBarAppearance
            navigationController.tabBarItem.setTitleTextAttributes(Constants.attributes, for: .normal)
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
            navigationController.tabBarItem = UITabBarItem(
                title: "Profile",
                image: UIImage(systemName: "person.circle"),
                selectedImage: UIImage(systemName:"person.circle.fill")
            )
        }
    }
    
}
