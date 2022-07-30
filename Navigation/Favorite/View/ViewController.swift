//
//  FavoriteViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 13.07.2022.
//

import UIKit
import SnapKit
import CoreData

class ViewController: UIViewController {
    
    // MARK: PROPERTIES
    
    private weak var coordinator: FavoriteCoordinator?
    private var post: FavoritePostEntity?
    private var favoritePosts = [Post]()
    
    
    private lazy var setFilterButton: CustomButton = {
        let button = CustomButton(
            title: "",
            titleColor: .white,
            backColor: .clear,
            backImage: (UIImage(systemName: "line.3.horizontal.decrease.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))?.withTintColor(.black, renderingMode: .alwaysOriginal))!)
       return button
    }()
    
    private lazy var deleteFilterButton: CustomButton = {
        let button = CustomButton(
            title: "",
            titleColor: .white,
            backColor: .clear,
            backImage: (UIImage(systemName: "trash", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))?.withTintColor(.black, renderingMode: .alwaysOriginal))!)
        button.layer.opacity = 0
        button.isEnabled = false
        return button
    }()
    
    private lazy var filterPredicateLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()
    
    
    private lazy var favoriteTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorInset = .zero
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.backgroundColor = .systemGray6
        return tableView
    }()
    
    // MARK: INITS

    init (coordinator: FavoriteCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupLayout()
        
        favoriteTableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: PostTableViewCell.identifire
        )
        
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: setFilterButton)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: deleteFilterButton)
        
        setFilterButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.showFilterAlert()
        }
        
        deleteFilterButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.reloadCoreDataFilesByFetch()
            self.filterPredicateLabel.text = nil
            self.deleteFilterButton.layer.opacity = 0
            self.deleteFilterButton.isEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadCoreDataFilesByFetch()
    }
    
    // MARK: LAYOUT

    func setupLayout() {
        
        self.view.addSubviews(filterPredicateLabel, favoriteTableView)

        filterPredicateLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.view)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        favoriteTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(self.view)
            make.top.equalTo(filterPredicateLabel.snp.bottom)
        }
    }
    
    // MARK: METHODS

    func reloadCoreDataFilesByFetch() {
        self.favoritePosts = CoreDataManager.shared.fetchFavourites()
        favoriteTableView.reloadData()
    }
    
    func showFilterAlert() {
        let alertController = UIAlertController(
            title: "Filter the favorite posts",
            message: "enter the author's name",
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Filter", style: .default) { action in
            let textField = alertController.textFields?[0]
            guard let text = textField?.text, text != "" else { return }
            self.filterFavoritePosts(text)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alertController.addTextField { textField in }
        alertController.addAction(action)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }
    
    func filterFavoritePosts (_ predicate: String) {
        self.favoritePosts = CoreDataManager.shared.fetchFiltredFavourites(predicate)
        self.filterPredicateLabel.text = "Filtred by: \"\(predicate)\""
        self.favoriteTableView.reloadData()
        self.deleteFilterButton.layer.opacity = 1
        self.deleteFilterButton.isEnabled = true
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifire, for: indexPath) as? PostTableViewCell else { return UITableViewCell() }

        let post = favoritePosts[indexPath.row]
        cell.configureOfCell(post)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /// не совсем понятно, зачем это делать через `UISwipeActionsConfiguration`, если можно использовать `editingStyleForRowAt`, ну да ладно.
    
    /// Конфигурирование удаления ячейки по свайпу
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let post = favoritePosts[indexPath.row]
        let delete = UIContextualAction(style: .destructive, title: "") { (action, view, completionHandler) in
            CoreDataManager.shared.deleteFavourite(post: post)
            
            self.favoritePosts.removeAll { element in
                element.personalID == post.personalID
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
                    
            completionHandler(true)
        }
        
        delete.image = getIcon("trash", 32)
        
        
        let swipeActionsConfig = UISwipeActionsConfiguration(actions: [delete])
        swipeActionsConfig.performsFirstActionWithFullSwipe = true
        
        return swipeActionsConfig
    }
}

