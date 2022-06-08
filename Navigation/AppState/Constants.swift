//
//  Constants.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 24.02.2022.
//

import UIKit

struct Constants {
    
    static let margin: CGFloat = 16
    static let offset: CGFloat = 20
    static let Inset: CGFloat = 8
}

public extension UIView {
    
    func addSubviews(_ subviews: UIView...) {
          subviews.forEach { addSubview($0) }
      }
}

public extension NSNotification.Name {
    static let codeRed = NSNotification.Name("codeRed")
    static let codeGreen = NSNotification.Name("codeGreen")
}
