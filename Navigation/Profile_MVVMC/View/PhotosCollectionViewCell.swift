//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 05.03.2022.
//

import UIKit
import iOSIntPackage
import SnapKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "PhotosCollectionViewCell"
    
    private let photo: UIImageView = {
        let photo = UIImageView()
        photo.contentMode = .scaleAspectFit
        return photo
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(photo)
        contentView.clipsToBounds = true
        
        photo.snp.makeConstraints { make in
            make.height.centerX.equalTo(contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var viewModel: PhotosCollectionViewCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            photo.image = viewModel.image
        }
    }
    
}

