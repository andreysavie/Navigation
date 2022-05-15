//
//  ViewController.swift
//  lection_tableView
//
//  Created by Андрей Рыбалкин on 22.02.2022.
//

import UIKit
import StorageService
import SnapKit

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    var viewModel: PostTableViewViewModelType?

    private var model: ProfileViewModel
    private weak var coordinator: ProfileCoordinator?

    let loginViewController = LogInViewController()
//    let photosViewController = PhotosViewController()
    
    var userService: UserService?
    var fullName: String
    
    //MARK: Задача 3. Создадим инициализацию для приёма параметров из контроллера авторизации
    
    //MARK: PROPERTIES
    
    static let tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.isScrollEnabled = true
        tableView.separatorInset = .zero
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 220
        tableView.backgroundColor = .systemGray6
        return tableView
    }()
    
    //MARK: INITS

    init (
        userService: UserService,
        name: String,
        model: ProfileViewModel,
        coordinator: ProfileCoordinator
    ) {
        self.userService = userService
        self.fullName = name
        self.model = model
        self.coordinator = coordinator

        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ProfileViewModel()
        
        self.view.addSubview(ProfileViewController.tableView)
        ProfileViewController.tableView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(self.view)
        }
        
        ProfileViewController.tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: PostTableViewCell.identifire
        )
        
        ProfileViewController.tableView.register(
            PhotosTableViewCell.self,
            forCellReuseIdentifier: PhotosTableViewCell.identifire
        )
        
        ProfileViewController.tableView.register(
            ProfileHeaderView.self,
            forHeaderFooterViewReuseIdentifier: ProfileHeaderView.identifire
        )
        
        ProfileViewController.tableView.dataSource = self
        ProfileViewController.tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: METHODS
    
//    func showPhotosVC() {
//        photosViewController.title = "Photo Gallery"
//        photosViewController.view.backgroundColor = .white
//        self.navigationController?.pushViewController(photosViewController, animated: true)
//        tabBarController?.tabBar.isHidden = true
//    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return viewModel?.numberOfRows() ?? 0
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: PhotosTableViewCell.identifire,
                for: indexPath) as! PhotosTableViewCell
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifire, for: indexPath) as? PostTableViewCell
            
            guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
            let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
            tableViewCell.viewModel = cellViewModel
            
            return tableViewCell
            
        default:
            return UITableViewCell()
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.identifire) as! ProfileHeaderView
        
        // MARK: Задача 3. Проведём валидацию пользователя и присвоим полям нужные значения
        
        let currentUser = userService?.userIdentify(name: fullName)
        headerView.nameLabel.text = currentUser?.fullName
        headerView.avatar.image = currentUser?.avatar
        headerView.statusLabel.text = currentUser?.status
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 0:
            return 220
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.section == 0 else { return }
        let coordinator = PhotosCoordinator()
        coordinator.showDetail(navCon: navigationController, coordinator: coordinator)
    }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
