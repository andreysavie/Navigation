//
//  VideoViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 11.06.2022.
//

import UIKit
import SnapKit

class VideoViewController: UIViewController {

    // MARK: PROPERTIES =============================================================================================

    private var viewModel: VideoViewModel?
    private weak var coordinator: VideoCoordinator?

    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped )
        table.separatorInset = .zero
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    // MARK: INITS =============================================================================================

    
    init (model: VideoViewModel , coordinator: VideoCoordinator) {
        self.viewModel = model
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(
            VideoTableViewCell.self,
            forCellReuseIdentifier: String(
                describing: VideoTableViewCell.self)
        )
        setupLayout()
    }
    
    
    // MARK: METHODS =============================================================================================

    private func setupLayout() {
        
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
    }
}

extension VideoViewController:  UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: VideoTableViewCell.self), for: indexPath) as? VideoTableViewCell else { return UITableViewCell() }
        cell.setConfigureOfCell(index: indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VideoViewModel.videos.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "   Список видео"
    }
}

extension VideoViewController:  UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let videoKey = Array(VideoViewModel.videos.keys)[indexPath.row]
        
        let playerCoordinator = VideoPlayerCoordinator()

        playerCoordinator.showDetail(navCon: navigationController, coordinator: playerCoordinator, key: videoKey)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

