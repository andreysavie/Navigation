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
//        contentView.addSubviews(photosTitle, arrowImage, photosView)
        contentView.addSubviews(photosTitle, arrowImage, photosView)

        
        setupConstraints()
    }
    
    private lazy var photosView: PhotosView = {
        
    let photosView = PhotosView()
        photosView.toAutoLayout()
        photosView.setupContent()
        return photosView
    }()
    
    private lazy var photosTitle: UILabel = {
        let photosTitle = UILabel()
        photosTitle.toAutoLayout()
        photosTitle.numberOfLines = 2
        photosTitle.text = "Photos"
        photosTitle.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return photosTitle
    }()
    
    // Временное название...
    
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
//
            photosTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photosTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),

            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrowImage.centerYAnchor.constraint(equalTo: photosTitle.centerYAnchor),
            arrowImage.heightAnchor.constraint(equalToConstant: 40),
            arrowImage.widthAnchor.constraint(equalToConstant: 40),

            photosView.topAnchor.constraint(equalTo: photosTitle.bottomAnchor, constant: 12),
            photosView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            photosView.heightAnchor.constraint(equalToConstant: 70),
            photosView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
