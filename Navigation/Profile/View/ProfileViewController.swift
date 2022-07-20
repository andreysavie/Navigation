//
//  ViewController.swift
//  lection_tableView
//
//  Created by Андрей Рыбалкин on 22.02.2022.
//

import UIKit
import StorageService
import SnapKit
import FirebaseAuth

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    private var viewModel: ProfileViewModel?
    private weak var coordinator: ProfileCoordinator?

    private let loginViewController = LogInViewController()
    
    private var userService: UserService?
    private var fullName: String
    
    private var cellIndexPathRow = 0
        
    //MARK: PROPERTIES ===================================================================================
    
    static let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.isScrollEnabled = true
        tableView.separatorInset = .zero
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 220
        tableView.backgroundColor = .systemGray6
        return tableView
    }()
    
    // MARK: - HW IOSDT 1.3
    private lazy var signOutBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: "Sign out",
            style: .plain,
            target: self,
            action: #selector(signOutButtonPressed)
        )
        return button
    }()
    
    private lazy var alertController: UIAlertController = {
        let alertController = UIAlertController(
            title: "Signing out",
            message: "Do you really want to sign out?",
            preferredStyle: .alert)
        
        let acceptAction = UIAlertAction(title: "OK", style: .default) { _ in
            do {
                try Auth.auth().signOut()
                self.pushLoginViewController()
                UserDefaults.standard.setValue(true, forKey: "isManuallySignOut")

            } catch {
                print(error.localizedDescription)
            }
        }
        alertController.addAction(acceptAction)
        
        let declineAction = UIAlertAction(title: "Cancel", style: .destructive)
        alertController.addAction(declineAction)

        return alertController
    }()


    
    //MARK: INITS ======================================================================================================

    init (
        userService: UserService,
        name: String,
        viewModel: ProfileViewModel,
        coordinator: ProfileCoordinator
    ) {
        self.userService = userService
        self.fullName = name
        self.viewModel = viewModel
        self.coordinator = coordinator

        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem  = signOutBarButtonItem
        
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
    
    // MARK: METHODS =================================================================================================

    // MARK: - HW IOSDT 1.3
    private func pushLoginViewController() {
        let coordinator = LoginCoordinator()
        let loginViewController = coordinator.showDetail(coordinator: coordinator)
        navigationController?.pushViewController(loginViewController, animated: true)
        navigationController?.setViewControllers([loginViewController], animated: true)
    }
    
    // MARK: OBJC METHODS =================================================================================================
    
    // MARK: - HW IOSDT 1.3
    @objc
    private func signOutButtonPressed() {
        present(alertController, animated: true)
    }

    // MARK: - HW IOSDT 2.4

    @objc
    private func doubleTap() {
        guard let post = viewModel?.posts[self.cellIndexPathRow] else { return }
        
        var isContains = false
        
        for favPost in CoreDataManager.shared.favoritePosts {
            if favPost.id == post.personalID {
                isContains = true
            }
        }
        
        if !isContains {
            CoreDataManager.shared.saveToCoreData(post: post)
        } else {
            print ("Element is already exists!")
        }
        
    }
}

// MARK: EXTENSIONS  =======================================================================================

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
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.doubleTap))
            recognizer.numberOfTapsRequired = 2

            // MARK: - HW IOSDT 2.4
            guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
            let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
            tableViewCell.viewModel = cellViewModel
            tableViewCell.addGestureRecognizer(recognizer)
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
        if indexPath.section == 0 {
        let coordinator = PhotosCoordinator()
        coordinator.showDetail(navCon: navigationController, coordinator: coordinator)
        } else {
            self.cellIndexPathRow = indexPath.row
        }
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
