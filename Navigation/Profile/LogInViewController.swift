//
//  LogInViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 20.02.2022.
//

import UIKit

struct ColorSet {
    
    static let mainColor = UIColor(named: "main_color")
}

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorSet.mainColor
    }
}
