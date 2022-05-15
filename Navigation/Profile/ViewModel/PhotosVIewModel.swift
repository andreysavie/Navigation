//
//  PhotosVIewModel.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 15.05.2022.
//

import Foundation
import UIKit

final class PhotosViewModel: PhotosCollectionViewViewModelType {
    
    private var newPhotoArray = [UIImage]()
    
    private let itemsPerRow: CGFloat = 3
    
    private let sectionInserts = UIEdgeInsets(
        top: Constants.Inset,
        left: Constants.Inset,
        bottom: Constants.Inset,
        right: Constants.Inset
    )
    
    var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = Constants.Inset
        layout.minimumLineSpacing = Constants.Inset
        layout.sectionInset = sectionInserts
        layout.scrollDirection = .vertical
        return layout
    }
    
    func receive(images: [UIImage], collectionView: UICollectionView) {
        newPhotoArray = images
        collectionView.reloadData()
    }
        
    func cellViewModel(forIndexPath indexPath: IndexPath, array: [UIImage]) -> PhotosCollectionViewCellViewModelType? {
        let image = array[indexPath.item]
        return PhotosCollectionViewCellViewModel(image: image)
    }
    
    func collectionViewLayout(collectionView: UICollectionView) -> CGSize {
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}


