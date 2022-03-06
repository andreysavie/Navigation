//
//  PhotosVIew.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 03.03.2022.
//

import UIKit

class PhotosPreview: UIView {


    let itemsPerRow: CGFloat = 4
    
    let sectionInserts = UIEdgeInsets(
        top: Constants.Inset,
        left: Constants.Inset,
        bottom: Constants.Inset,
        right: Constants.Inset
    )
    

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
        collection.register(PhotosPreviewCollectionViewCell.self, forCellWithReuseIdentifier: PhotosPreviewCollectionViewCell.identifire)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()

     func setupContent() {
         self.addSubview(collectionView)
         setupPhotosPreviewConstraints()
    }
    
    private func setupPhotosPreviewConstraints() {
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension PhotosPreview: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosPreviewCollectionViewCell.identifire, for: indexPath) as? PhotosPreviewCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: photosArray[indexPath.item])
        return cell
    }
}

extension PhotosPreview: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = (availableWidth / itemsPerRow) - sectionInserts.left / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem * 0.85)
    }
}
