//
//  ViewController.swift
//  lection_tableView
//
//  Created by Андрей Рыбалкин on 22.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {
            
    let tableView: UITableView = {
      
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.isScrollEnabled = true
        tableView.separatorInset = .zero
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 220
        tableView.rowHeight = UITableView.automaticDimension

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
        
        self.tableView.register(
            ProfileHeaderView.self,
            forHeaderFooterViewReuseIdentifier: ProfileHeaderView.identifire
        )

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    private func setupTableViewCOnstraints() {
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifire, for: indexPath) as! PostTableViewCell
        cell.setConfigureOfCell(post: posts[indexPath.row])        
        return cell
    }
    
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
                    let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.identifire) as! ProfileHeaderView
                    return headerView
                } else { return nil }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 220
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

//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.pushViewController(loginViewController, animated: true)
//    }
