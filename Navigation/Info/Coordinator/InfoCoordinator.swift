//
//  InfoCoordinator.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 22.06.2022.
//

import Foundation
import UIKit

final class InfoCoordinator {
    func showDetail(navCon: UINavigationController?, coordinator: InfoCoordinator) {
        let viewModel = InfoViewModel()
        let viewController = InfoViewController(viewModel: viewModel, coordinator: coordinator)
        viewController.title = "information"
        viewController.view.backgroundColor = UIColor(displayP3Red: 0.130, green: 0.130, blue: 0.130, alpha: 1)
        navCon?.present(viewController, animated: true, completion: nil)
    }
}
