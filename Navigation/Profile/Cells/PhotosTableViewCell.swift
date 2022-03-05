//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 02.03.2022.
//

// MARK: ВЫНЕСТИ PhotosCollectionViewCell в отдельный файл!!!

import UIKit

class PhotosTableViewCell: UITableViewCell {

    static let identifire = "PhotosTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(photosTitle, arrowImage, photosPreview)
        setupConstraints()
    }
    
    private lazy var photosPreview: PhotosPreview = {
            let photosPreview = PhotosPreview()
        photosPreview.toAutoLayout()
        photosPreview.setupContent()
        return photosPreview
    }()
    
    private lazy var photosTitle: UILabel = {
        let photosTitle = UILabel()
        photosTitle.toAutoLayout()
        photosTitle.numberOfLines = 2
        photosTitle.text = "Photos"
        photosTitle.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return photosTitle
    }()
    
    private lazy var arrowImage: UIImageView = {
        let arrowImage = UIImageView()
        arrowImage.toAutoLayout()
        arrowImage.image = UIImage(systemName: "arrow.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return arrowImage
    }()

        
    // MARK: Constraints
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            
            contentView.widthAnchor.constraint(equalTo: self.widthAnchor),

            photosTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Inset),
            photosTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Inset),

            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Inset),
            arrowImage.centerYAnchor.constraint(equalTo: photosTitle.centerYAnchor),
            arrowImage.heightAnchor.constraint(equalToConstant: 40),
            arrowImage.widthAnchor.constraint(equalToConstant: 40),

            photosPreview.topAnchor.constraint(equalTo: photosTitle.bottomAnchor, constant: Constants.Inset),
            photosPreview.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            photosPreview.heightAnchor.constraint(equalToConstant: 70),
            photosPreview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Inset)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
