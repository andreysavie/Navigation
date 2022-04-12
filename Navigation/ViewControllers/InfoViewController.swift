//
//  InfoViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 11.02.2022.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "information"
        view.backgroundColor = UIColor(displayP3Red: 0.130, green: 0.130, blue: 0.130, alpha: 1)
        
        let button = UIButton(
            frame: CGRect(
                x: UIScreen.main.bounds.midX - 75,
                y: UIScreen.main.bounds.midY - 25,
                width: 150,
                height: 50
            )
        )
        
        button.layer.cornerRadius = button.frame.size.height / 4
        button.backgroundColor = .systemIndigo
        button.setTitle("Show info", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.autoresizingMask = .init(arrayLiteral: [.flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin])
        self.view.addSubview(button)
    }
    
    @objc func buttonAction(sender: UIButton!) {
                
        let alertController = UIAlertController(title: "⚠️ Attention ⚠️", message: "You have opened my first alert written with code. Do you like him?", preferredStyle: .alert)
        
        let acceptAction = UIAlertAction(title: "Yes", style: .default) { (_) -> Void in
            print("thank you so much!")
        }
        
        let declineAction = UIAlertAction(title: "No", style: .destructive) { (_) -> Void in
            print("very sad :(")
        }
        
        alertController.addAction(acceptAction)
        alertController.addAction(declineAction)

        present(alertController, animated: true, completion: nil)
    }
}




