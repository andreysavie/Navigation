//
//  PhotosVIew.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 03.03.2022.
//

import UIKit
import SnapKit

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
        collection.register(
            PhotosPreviewCollectionViewCell.self,
            forCellWithReuseIdentifier:PhotosPreviewCollectionViewCell.identifire)
        
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    func setupContent() {
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}

extension PhotosPreview: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosPreviewCollectionViewCell.identifire, for: indexPath) as? PhotosPreviewCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(image: filtredPhotosArray[indexPath.item])
        return cell
    }
}

extension PhotosPreview: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = UIScreen.main.bounds.width - paddingWidth
        let widthPerItem = (availableWidth / itemsPerRow) - sectionInserts.left / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem * 0.85)
    }
}
