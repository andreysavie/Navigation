//
//  ViewController.swift
//  lection_tableView
//
//  Created by Андрей Рыбалкин on 22.02.2022.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    let loginViewController = LogInViewController()
    let photosViewController = PhotosViewController()
    let profileView = ProfileHeaderView()

    
    static let tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.isScrollEnabled = true
        tableView.separatorInset = .zero
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 220
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(ProfileViewController.tableView)
        setupConstraints()
        
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
    
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            ProfileViewController.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            ProfileViewController.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            ProfileViewController.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            ProfileViewController.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    func showPhotosVC() {
        photosViewController.title = "Photo Gallery"
        photosViewController.view.backgroundColor = .white
        self.navigationController?.pushViewController(photosViewController, animated: true)
        tabBarController?.tabBar.isHidden = true
    }
    
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
            return posts.count
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
            let cell = tableView.dequeueReusableCell(
                withIdentifier: PostTableViewCell.identifire,
                for: indexPath) as! PostTableViewCell
            cell.setConfigureOfCell(post: posts[indexPath.row])
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.identifire) as! ProfileHeaderView
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

        guard indexPath.section == 0 else {return}
        showPhotosVC()
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
