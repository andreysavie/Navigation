//
//  InfoViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 11.02.2022.
//

import UIKit
import SnapKit

class InfoViewController: UIViewController {
    
    
    // MARK: PROPERTIES =======================================================================
    
    private var networkManager = ResinentsNetworkManager()
    private var viewModel: InfoViewModel?
    private weak var coordinator: InfoCoordinator?
    
    private lazy var showInfoButton: CustomButton = {
        let button = CustomButton (
            title: "Show info",
            titleColor: .white,
            backColor: .systemIndigo,
            backImage: UIImage()
        )
        return button
    }()
    
    private lazy var fetchedModelLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = ColorSet.mainColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var planetsModelLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = ColorSet.mainColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var residentsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    
    // MARK: INITS =======================================================================
    
    init (viewModel: InfoViewModel, coordinator: InfoCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        residentsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        
        residentsTableView.dataSource = self
        
        fetchedModelLabel.text = InfoNetworkManager.shared.infoModel.title
        planetsModelLabel.text = "orbital period is \(PlanetsNetworkManager.shared.planet!.orbitalPeriod)"
        
        
        self.view.addSubviews(
            showInfoButton,
            fetchedModelLabel,
            planetsModelLabel,
            residentsTableView
        )
        
        setupInfoLayout()
        
        showInfoButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.showInfoButtonPressed()
        }
        
        ResinentsNetworkManager.shared.fetchResidentsData()
        
        ResinentsNetworkManager.shared.reloadTableViewData = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.residentsTableView.reloadData()
            }
        }
    }
    
    
    // MARK: METHODS =======================================================================
    
    private func setupInfoLayout() {
        
        residentsTableView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(fetchedModelLabel.snp.top).offset(-16)
        }
        
        showInfoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(200)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        fetchedModelLabel.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.top.equalTo(showInfoButton.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
        
        planetsModelLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.bottom.equalTo(showInfoButton.snp.top).offset(-32)
            make.centerX.equalToSuperview()
        }
    }
    
    private func showInfoButtonPressed() {
        guard let viewModel = viewModel else { return }
        viewModel.presentAlert(viewController: self)
    }
    
}

// MARK: EXTENSIONS =======================================================================

extension InfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ResinentsNetworkManager.shared.residents.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "Cell")
        cell.textLabel!.text = ResinentsNetworkManager.shared.residents[indexPath.row].name
        cell.textLabel!.textColor = .white
        cell.backgroundColor = ColorSet.mainColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
