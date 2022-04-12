//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 05.03.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
        static let identifire = "PhotosCollectionViewCell"

    private let photo: UIImageView = {
        let photo = UIImageView()
        photo.toAutoLayout()
        photo.contentMode = .scaleAspectFit
        return photo
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(photo)

        setupPhotoCellConstraints()
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPhotoCellConstraints() {
        
        NSLayoutConstraint.activate([
            photo.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            photo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func configure(with photoName: String) {
        photo.image = UIImage(named: photoName)
    }

}
