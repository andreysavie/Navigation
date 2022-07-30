//
//  FavoriteViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 13.07.2022.
//

import UIKit
import SnapKit
import CoreData

class FavoriteViewController: UIViewController {
    
    // MARK: PROPERTIES
    
    private weak var coordinator: FavoriteCoordinator?
    private var post: FavoritePostEntity?
    private var favoritePosts = [Post]()
    
    private var fetchedResultsController = CoreDataManager.shared.fetchedResultsController

    
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
        fetchedResultsController.delegate = self

        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: setFilterButton)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: deleteFilterButton)
        
        setFilterButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.showFilterAlert()
        }
        
        deleteFilterButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.filterPredicateLabel.text = nil
            self.deleteFilterButton.layer.opacity = 0
            self.deleteFilterButton.isEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteTableView.reloadData()
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
    
    func filterFavoritePosts (_ author: String) {
        
        self.filterPredicateLabel.text = "Filtred by: \"\(author)\""
        self.favoriteTableView.reloadData()
        self.deleteFilterButton.layer.opacity = 1
        self.deleteFilterButton.isEnabled = true
    }
    
}

extension FavoriteViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]

        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifire, for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        
        let post = fetchedResultsController.object(at: indexPath)

        cell.configureOfCell(post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let context = fetchedResultsController.managedObjectContext
            context.delete(fetchedResultsController.object(at: indexPath))

            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension FavoriteViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        favoriteTableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            favoriteTableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            favoriteTableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            favoriteTableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            favoriteTableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            guard  let indexPath = indexPath, let cell = favoriteTableView.cellForRow(at: indexPath) as? PostTableViewCell else { return }
            cell.configureOfCell(anObject as! FavoritePostEntity)
        case .move:
            guard
                let indexPath = indexPath,
                let newIndexPath = newIndexPath,
                let cell = favoriteTableView.cellForRow(at: indexPath) as? PostTableViewCell
            else { return }
            
            cell.configureOfCell(anObject as! FavoritePostEntity)
            favoriteTableView.moveRow(at: indexPath, to: newIndexPath)

        @unknown default:
            fatalError()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        favoriteTableView.endUpdates()
    }
}
