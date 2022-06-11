//
//  VideoViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 11.06.2022.
//

import UIKit
import SnapKit

class VideoViewController: UIViewController {

    private var viewModel: VideoViewModel?
    private weak var coordinator: VideoCoordinator?
    
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped )
        table.separatorInset = .zero
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    
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

        view.addSubview(tableView)
        setupLayout()

    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
    }
}

extension VideoViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: VideoTableViewCell.self), for: indexPath) as? VideoTableViewCell,
        let viewModel = viewModel else { return UITableViewCell() }
        cell.setConfigureOfCell(model: viewModel, index: indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Список видео"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.playButtonPressed(navController: self.navigationController!)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

    


class VideoTableViewCell: UITableViewCell {
    
    // MARK: PROPERTIES ============================================================================

    private lazy var videoNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var videoIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "video", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return image
    }()
    
    // MARK: INITIALIZATORS ============================================================================

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(videoNameLabel, videoIcon)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: METHODS ===================================================================================

    func setupLayout() {
                
        videoIcon.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(12)
        }
        
        videoNameLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.equalTo(videoIcon.snp.trailing).offset(12)
        }
    }
    
    func setConfigureOfCell(model: VideoViewModel, index: Int) {
        
        videoNameLabel.text = "TEST"
    }
}

