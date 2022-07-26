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
    
    private lazy var setFilterButton = CustomButton(
        title: "",
        titleColor: .white,
        backColor: .clear,
        backImage: (UIImage(systemName: "line.3.horizontal.decrease.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))?.withTintColor(.black, renderingMode: .alwaysOriginal))!
    )
    
    private lazy var deleteFilterButton = CustomButton(
        title: "",
        titleColor: .white,
        backColor: .clear,
        backImage: (UIImage(systemName: "trash", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))?.withTintColor(.black, renderingMode: .alwaysOriginal))!
    )
    
    
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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: setFilterButton)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: deleteFilterButton)

        setFilterButton.tapAction = { [weak self] in
            print ("SET FILTER!")
//            guard let self = self else { return }
//            self.showInfoButtonPressed()
        }
        
        deleteFilterButton.tapAction = { [weak self] in
//            guard let self = self else { return }
//            self.showInfoButtonPressed()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadCoreDataFilesByFetch()
    }
    
    func reloadCoreDataFilesByFetch() {
        self.favoritePosts = CoreDataManager.shared.fetchFavourites()
        favoriteTableView.reloadData()
    }
}

extension FavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: FavoritePostTableViewCell.identifire, for: indexPath) as? FavoritePostTableViewCell        else { return UITableViewCell() }
        let post = favoritePosts[indexPath.row]
        cell.configureOfCell(post)
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let post = favoritePosts[indexPath.row]

        let delete = UIContextualAction(style: .destructive, title: "DELETE") { (action, view, completionHandler) in

            CoreDataManager.shared.deleteFavourite(post: post)
            
            self.favoritePosts.removeAll { element in
                element.personalID == post.personalID
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
//            self.reloadCoreDataFilesByFetch()
            
            self.favoritePosts.forEach({ print("♻️\($0.title)") }) // CHECKING!

            completionHandler(true)
        }
        
        let swipeActionsConfig = UISwipeActionsConfiguration(actions: [delete])
        swipeActionsConfig.performsFirstActionWithFullSwipe = false
        
        return swipeActionsConfig
    }
}

