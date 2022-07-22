//
//  FavoriteViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 13.07.2022.
//

import UIKit
import SnapKit

class FavoriteViewController: UIViewController {
    
    private weak var coordinator: FavoriteCoordinator?
    private var post: FavoritePostEntity?
    private var favoritePosts = [Post]()
    
    
    private lazy var favoriteTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorInset = .zero
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.backgroundColor = .systemGray6
        return tableView
    }()
    
    
    init (coordinator: FavoriteCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(favoriteTableView)
        favoriteTableView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(self.view)
        }
        
        favoriteTableView.register(
            FavoritePostTableViewCell.self,
            forCellReuseIdentifier: FavoritePostTableViewCell.identifire
        )
        
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.favoritePosts = CoreDataManager.shared.fetchFavourites()
        favoriteTableView.reloadData()
    }
    
}
    
    
    extension FavoriteViewController: UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return CoreDataManager.shared.favoritePosts.count
                    return favoritePosts.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: FavoritePostTableViewCell.identifire, for: indexPath) as? FavoritePostTableViewCell        else { return UITableViewCell() }
//            let post = CoreDataManager.shared.favoritePosts[indexPath.row]
            let post = favoritePosts[indexPath.row]
            cell.configureOfCell(post)
            return cell
        }
    }
    
    extension FavoriteViewController: UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
