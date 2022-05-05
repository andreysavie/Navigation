//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 05.03.2022.
//

import UIKit
import iOSIntPackage
import SnapKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "PhotosCollectionViewCell"
    
    //MARK: For PhotoFilters
    private let filtersSet: [ColorFilter] = [.colorInvert, .noir, .chrome, .fade, .posterize, .tonal,
                                             .process, .transfer, .bloom(intensity: 10),
                                             .sepia(intensity: 80)]
    
    private var imageProcessor: ImageProcessor {
        return ImageProcessor()
    }
    
    private let photo: UIImageView = {
        let photo = UIImageView()
        photo.contentMode = .scaleAspectFit
        return photo
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(photo)
        
        PhotoCellLayout()
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func PhotoCellLayout() {
        
        photo.snp.makeConstraints { make in
            make.height.centerX.equalTo(contentView)
            
        }
    }
    
    
    func configure(with photoName: String) {
        photo.image = UIImage(named: photoName)
        
        guard let image = photo.image else { return }
        
        // Добавим наложение фильтра при помощи зависимости iOSIntPackage:
        imageProcessor.processImage(sourceImage: image, filter: getRandomFilter(set: filtersSet)) { filteredImage in
            photo.image = filteredImage
        }
    }
    
    // метод для выдачи случайного фотофильтра из представленного массива
    func getRandomFilter (set: [ColorFilter]) -> ColorFilter {
        let randomFilterNumber = Int.random(in: 0..<set.count)
        return set[randomFilterNumber]
    }
}

