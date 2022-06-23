//
//  InfoViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 11.02.2022.
//

import UIKit
import SnapKit

class InfoViewController: UIViewController {
    
//    let fetchManager = InfoNetworkManager()
    
    // MARK: PROPERTIES

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
    
    
    // MARK: INITS

    init (viewModel: InfoViewModel, coordinator: InfoCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        
        self.fetchedModelLabel.text = InfoNetworkManager.shared.infoModel.title
        self.planetsModelLabel.text = PlanetsNetworkManager.shared.planet?.orbitalPeriod

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.view.addSubviews(showInfoButton, fetchedModelLabel, planetsModelLabel)
        
        setupInfoLayout()
        
        showInfoButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.showInfoButtonPressed()
        }
    }
    

    // MARK: METHODS
    
    func setupInfoLayout() {
        
        showInfoButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
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
