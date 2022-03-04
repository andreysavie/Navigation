//
//  PhotosVIew.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 03.03.2022.
//

import UIKit

class PhotosView: UIView {

    
    private let photos = ["pic_1", "pic_2", "pic_3", "pic_4", "pic_5", "pic_6", "pic_7", "pic_8", "pic_9", "pic_10", "pic_11", "pic_12", "pic_13", "pic_14", "pic_15", "pic_16", "pic_17", "pic_18", "pic_19", "pic_20"]

    let itemsPerRow: CGFloat = 4
    let sectionInserts = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)


    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = sectionInserts.left
        layout.sectionInset = sectionInserts
        layout.scrollDirection = .horizontal
        return layout
        
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .white
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()

    
     func setupContent() {
         self.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension PhotosView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: photos[indexPath.item])
        return cell
    }
}

extension PhotosView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = (availableWidth / itemsPerRow) - sectionInserts.left / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem * 0.85)
    }
}

final class PhotosCollectionViewCell: UICollectionViewCell {
        
    private let photo: UIImageView = {
       let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        return photo
    }()

    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupCellContent()
        contentView.layer.cornerRadius = 6
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellContent() {
        contentView.addSubview(photo)
        
        NSLayoutConstraint.activate([
    photo.heightAnchor.constraint(equalTo: contentView.heightAnchor),
    photo.widthAnchor.constraint(equalTo: contentView.widthAnchor)
])
    }
        
    func configure(with photoName: String) {
        photo.image = UIImage(named: photoName)
    }
}
