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
    
    static let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
    
    static let navigationBarAppearance: UINavigationBarAppearance = {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemGray5
        return appearance
    }()
}

// MARK: - Task 8: for asynchronous development and multithreading
extension Constants {
    
    static func timeToString(sec: Double) -> String {
        let minutes = Int(sec) / 60
        let seconds = sec - Double(minutes) * 60
        let secondsFraction = seconds - Double(Int(seconds))
        return String(format:"%02i:%02i.%02d",minutes,Int(seconds),Int(secondsFraction * 100.0))
    }
    
    static func showElapsedTimeAlert(navCon: UINavigationController, sec: Double)  {
        let alertController = UIAlertController(
            title: "Done!",
            message: "elapsed time: \(timeToString(sec: sec))",
            preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        navCon.present(alertController, animated: true, completion: nil)
    }
}
public extension UIView {
    
    func addSubviews(_ subviews: UIView...) {
          subviews.forEach { addSubview($0) }
      }
    
    func getButton (icon name: String, action: Selector ) -> UIButton {
        let button = UIButton()
        button.setCustomImage(name: name, size: 32)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }

}

public extension UIButton {
    
    func setCustomImage (name: String, size: CGFloat) {
        setImage((UIImage(systemName: name, withConfiguration: UIImage.SymbolConfiguration(pointSize: size))?.withTintColor(.black, renderingMode: .alwaysOriginal))!, for: .normal)
    }
}


public extension NSNotification.Name {
    static let codeRed = NSNotification.Name("codeRed")
    static let codeGreen = NSNotification.Name("codeGreen")
    
    static let playPause = NSNotification.Name("playPause")
}


