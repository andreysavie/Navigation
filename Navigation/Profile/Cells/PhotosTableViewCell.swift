//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 02.03.2022.
//

import UIKit
import SnapKit

class PhotosTableViewCell: UITableViewCell {

    // MARK: PROPERTIES

    static let identifire = "PhotosTableViewCell"
    
    private lazy var photosPreview: PhotosPreview = {
            let photosPreview = PhotosPreview()
        photosPreview.setupContent()
        return photosPreview
    }()
    
    private lazy var photosTitle: UILabel = {
        let photosTitle = UILabel()
        photosTitle.numberOfLines = 2
        photosTitle.text = "Photos"
        photosTitle.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return photosTitle
    }()
    
    private lazy var arrowImage: UIImageView = {
        let arrowImage = UIImageView()
        arrowImage.image = UIImage(systemName: "arrow.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return arrowImage
    }()

    // MARK: INITS

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(photosTitle, arrowImage, photosPreview)
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: METHODS
    
    private func setupConstraints(){
        
        photosTitle.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView).inset(12)
        }
        
        arrowImage.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(12)
            make.centerY.equalTo(photosTitle)
            make.width.height.equalTo(40)
        }
        
        photosPreview.snp.makeConstraints { make in
            make.top.equalTo(photosTitle.snp.bottom).offset(12)
            make.width.equalTo(contentView)
            make.height.equalTo(80)
            make.bottom.equalTo(contentView).inset(12)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
