//
//  PostViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 11.02.2022.
//

import UIKit

class NewPostViewController: UIViewController {
    
    // MARK: PROPERTIES

    private var viewModel: NewPostViewModel?
    private weak var coordinator: NewPostCoordinator?

    // MARK: INITS

    init (viewModel: NewPostViewModel, coordinator: NewPostCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let infoBarButtonItem = UIBarButtonItem(
            title: "Info",
            style: .plain,
            target: self,
            action: #selector(showInfo)
        )
        self.navigationItem.rightBarButtonItem  = infoBarButtonItem
        view.backgroundColor = UIColor(displayP3Red: 0.130, green: 0.130, blue: 0.130, alpha: 1.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    // MARK: METHODS

    @objc func showInfo() {
        let coordinator = InfoCoordinator()
        coordinator.showDetail(navCon: navigationController, coordinator: coordinator)
    }
    
}

