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
    
    func presentAlert (viewController: UIViewController) {
        viewController.present(infoAlert, animated: true, completion: nil)
    }

}
