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
    
    private lazy var photo: UIImageView = {
        let photo = UIImageView()
        photo.layer.cornerRadius = 10
        photo.clipsToBounds = true
        return photo
    }()
    
    private lazy var photosPreviewStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .white
        return stackView
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
        arrowImage.image = UIImage(
            systemName: "arrow.right",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return arrowImage
    }()

    // MARK: INITS

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(photosTitle, arrowImage, photosPreviewStackView)
        
        for i in 0...3 {
            photo = UIImageView(image: UIImage(named: photosArray[i]))
            photo.layer.cornerRadius = 6
            photo.clipsToBounds = true
            photosPreviewStackView.addArrangedSubview(photo)
        }
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: METHODS
    
    private func setupLayout(){
        
        photosTitle.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView).inset(12)
        }
        
        arrowImage.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(12)
            make.centerY.equalTo(photosTitle)
            make.width.height.equalTo(40)
        }
        
        photosPreviewStackView.snp.makeConstraints { make in
            make.top.equalTo(photosTitle.snp.bottom).offset(8)
            make.leading.trailing.equalTo(contentView).inset(8)
            make.height.equalTo(80)
            make.bottom.equalTo(contentView).inset(12)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
