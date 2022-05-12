//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 12.05.2022.
//

import UIKit

final class MainCoordinator: Coordinator {
    func startApplication() -> UIViewController {
        return MainTabBarViewController()
    }
}
