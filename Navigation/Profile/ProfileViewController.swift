//
//  ViewController.swift
//  lection_tableView
//
//  Created by Андрей Рыбалкин on 22.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let loginViewController = LogInViewController() // убрать
    let photosViewController = PhotosViewController()
    let postVC = PostViewController()
    let tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.isScrollEnabled = true
        tableView.separatorInset = .zero
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 220
//        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        setupTableViewCOnstraints()
        
        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: PostTableViewCell.identifire
        )
        
        tableView.register(
            PhotosTableViewCell.self,
            forCellReuseIdentifier: PhotosTableViewCell.identifire
        )
        
        self.tableView.register(
            ProfileHeaderView.self,
            forHeaderFooterViewReuseIdentifier: ProfileHeaderView.identifire
        )
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        hideKeyboardWhenTappedAround()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard LogInViewController.isLogin == false else { return }
        self.navigationController?.pushViewController(loginViewController, animated: true)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupTableViewCOnstraints() {
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
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
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifire, for: indexPath) as! PhotosTableViewCell
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifire, for: indexPath) as! PostTableViewCell
            cell.setConfigureOfCell(post: posts[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
}
extension ProfileViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.identifire) as! ProfileHeaderView
            return headerView
        } else { return nil }
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

        if indexPath.section == 0 {
//            navigationController?.pushViewController(photosViewController, animated: true)

//            navigationController?.pushViewController(postVC, animated: true)
            showPhotosVC()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
}

extension UIViewController {
   
    // сменить название!
    
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
