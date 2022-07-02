//
//  CustomTextfield.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 02.07.2022.
//

import Foundation
import UIKit

final class CustomTextfield: UITextField {
    
    var textChangedAction: (() -> Void)?

    let customPlaceholder: String
    let secure: Bool
    let iconName: String
    
    init (
        customPlaceholder: String,
        secure: Bool,
        iconName: String
    ) {
        self.customPlaceholder = customPlaceholder
        self.secure = secure
        self.iconName = iconName
        
        super.init(frame: .zero)
        
        leftViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        
        placeholder = customPlaceholder
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.25
        textColor = .black
        font = UIFont.systemFont(ofSize: 16)
        
        let icon = UIImageView(image: UIImage(systemName: iconName))
        icon.tintColor = ColorSet.mainColor
        leftView = textFieldIcon(subView: icon)
        
        autocorrectionType = .no
        autocapitalizationType = .none
        keyboardType = .emailAddress
        returnKeyType = .done
        clearButtonMode = UITextField.ViewMode.whileEditing
        isSecureTextEntry = secure
        addTarget(self, action: #selector(textChanged), for: .editingChanged)

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func textChanged() {
        textChangedAction?()
    }
    
    private func textFieldIcon (subView: UIView) -> UIView {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        leftView.addSubview(subView)
        subView.center = leftView.center
        return leftView
    }
}


