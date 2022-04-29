//
//  PhotosPreviewCollectionViewCell.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 04.03.2022.
//

import UIKit
import SnapKit

class PhotosPreviewCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "PhotosPreviewCollectionViewCell"
   
    private let photo: UIImageView = {
        let photo = UIImageView()
        return photo
    }()

        override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(photo)
        contentView.layer.cornerRadius = 6
        contentView.clipsToBounds = true
        PhotosPreviewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
         
    func PhotosPreviewLayout() {
        photo.snp.makeConstraints { make in
            make.width.height.equalTo(contentView)
        }
    }
    
    func configure(image: UIImage) {
        self.photo.image = image
    }
}
