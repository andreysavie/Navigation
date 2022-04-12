//
//  PhotosPreviewCollectionViewCell.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 04.03.2022.
//

import UIKit

class PhotosPreviewCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "PhotosPreviewCollectionViewCell"
   
    private let photo: UIImageView = {
       let photo = UIImageView()
        photo.toAutoLayout()
        return photo
    }()

        override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(photo)
        contentView.layer.cornerRadius = 6
        contentView.clipsToBounds = true
        setupPhotosPreviewCellConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
         
    func setupPhotosPreviewCellConstraints() {
        NSLayoutConstraint.activate([
    photo.heightAnchor.constraint(equalTo: contentView.heightAnchor),
    photo.widthAnchor.constraint(equalTo: contentView.widthAnchor)
])

    }
    
    func configure(with photoName: String) {
        photo.image = UIImage(named: photoName)
    }

}
