//
//  PhotosCollectionViewViewModelType.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 15.05.2022.
//

import Foundation
import UIKit

protocol PhotosCollectionViewViewModelType {
    
//    func numberOfRows() -> Int
    
    var layout: UICollectionViewFlowLayout { get }
    
    func receive(images: [UIImage], collectionView: UICollectionView) 
    
//    func numberOfItemsInSection() -> Int

//    func cellViewModel(forIndexPath indexPath: IndexPath) -> PhotosCollectionViewCellViewModelType?
    func cellViewModel(forIndexPath indexPath: IndexPath, array: [UIImage]) -> PhotosCollectionViewCellViewModelType?
    
    func collectionViewLayout(collectionView: UICollectionView) -> CGSize
}



