//
//  InfoViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 11.02.2022.
//

import UIKit
import SnapKit

class InfoViewController: UIViewController {
    
    // MARK: PROPERTIES

    private lazy var showInfoButton: CustomButton = {
        let button = CustomButton (
            title: "Show info",
            titleColor: .white,
            backColor: .systemIndigo,
            backImage: UIImage()
        )
        return button
    }()
    
    // MARK: INITS

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "information"
        view.backgroundColor = UIColor(displayP3Red: 0.130, green: 0.130, blue: 0.130, alpha: 1)
        self.view.addSubview(showInfoButton)
        setupInfoLayout()
        
        showInfoButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.showInfoButtonPressed()
        }
    }
    
    // MARK: METHODS
    
    private func setupInfoLayout() {
        showInfoButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }

    private func showInfoButtonPressed() {
        let alertController = UIAlertController(title: "⚠️ Attention ⚠️", message: "Do you like that?", preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "Yes", style: .default) { _ in
            print("thank you so much!")
        }
        let declineAction = UIAlertAction(title: "No", style: .destructive) { _ in
            print("very sad :(")
        }
        alertController.addAction(acceptAction)
        alertController.addAction(declineAction)
        present(alertController, animated: true, completion: nil)
    }
}




