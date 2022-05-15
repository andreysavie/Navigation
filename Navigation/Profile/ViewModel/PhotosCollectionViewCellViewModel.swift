//
//  PhotosCollectionViewCellViewModel.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 15.05.2022.
//

import Foundation
import UIKit

class PhotosCollectionViewCellViewModel: PhotosCollectionViewCellViewModelType {
    
    var image: UIImage
    
    init (image: UIImage) {
        self.image = image
    }
      
}

