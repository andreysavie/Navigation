//
//  FavoriteViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 13.07.2022.
//

import UIKit
import SnapKit

class FavoriteViewController: UIViewController {
    
    private var viewModel: FavoriteViewModel?
    private weak var coordinator: FavoriteCoordinator?
    private var post: FavoritePostEntity?
    
    private lazy var favoriteTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorInset = .zero
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.backgroundColor = .systemGray6
        return tableView
    }()
    
    
    init (model: FavoriteViewModel, coordinator: FavoriteCoordinator) {
        self.viewModel = model
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        viewModel = FavoriteViewModel()
        
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
    
//    override func viewDidAppear(_ animated: Bool) {
//        favoriteTableView.reloadData()
//    }
}

extension FavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print ("🦁\(FavoriteViewModel.shared.favoritePosts.count)")
        return FavoriteViewModel.shared.favoritePosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: FavoritePostTableViewCell.identifire, for: indexPath) as? FavoritePostTableViewCell
        else { return UITableViewCell() }
        let post = FavoriteViewModel.shared.favoritePosts[indexPath.row]
        cell.configureOfCell(post)
        return cell
        
        //            guard let cell = cell, let viewModel = viewModel else { return UITableViewCell() }
        //            let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        //            cell.favoriteViewModel = cellViewModel
        //            return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

