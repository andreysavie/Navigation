//
//  InfoViewModel.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 15.05.2022.
//

import Foundation
import UIKit
import SnapKit

final class InfoViewModel {
    
//    var showInfoButton: CustomButton {
//        let button = CustomButton (
//            title: "Show info",
//            titleColor: .white,
//            backColor: .systemIndigo,
//            backImage: UIImage()
//        )
//        return button
//    }
    
    var infoAlert: UIAlertController {
        let alertController = UIAlertController(title: "⚠️ Attention ⚠️", message: "Do you like that?", preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "Yes", style: .default) { _ in
            print("thank you so much!")
        }
        let declineAction = UIAlertAction(title: "No", style: .destructive) { _ in
            print("very sad :(")
        }
        alertController.addAction(acceptAction)
        alertController.addAction(declineAction)
        
        return alertController
    }
    
    
    func setupInfoLayout(button: UIButton, label: UILabel) {
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        label.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.top.equalTo(button.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func presentAlert (viewController: UIViewController) {
        viewController.present(infoAlert, animated: true, completion: nil)
    }

}
