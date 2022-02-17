//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 10.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    
    var gradientBackGround = CAGradientLayer() {
        didSet{
            gradientBackGround.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientBackGround.endPoint = CGPoint(x: 0.0, y: 1.0)
            gradientBackGround.colors = [UIColor.systemTeal.cgColor, UIColor.blue.cgColor]
        }
    }
    
    override func viewDidLayoutSubviews() {
        gradientBackGround.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientBackGround = CAGradientLayer()
        view.layer.insertSublayer(gradientBackGround, at: 0)

    }    
}
