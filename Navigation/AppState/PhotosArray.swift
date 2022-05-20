//
//  PhotosArray.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 05.03.2022.
//


//    testPhotosArray = (1...20).compactMap { UIImage(named: "pic_\($0)")}

import UIKit
import iOSIntPackage

let filtersSet: [ColorFilter] = [.colorInvert, .noir, .chrome, .fade, .posterize, .tonal,
                                         .process, .transfer, .bloom(intensity: 10),
                                         .sepia(intensity: 80)]

let photosArray = (1...20).compactMap {"pic_\($0)"}
let threadPhotosArray = (1...20).compactMap {UIImage(named: "pic_\($0)") }

private let imageProcessor = ImageProcessor()

public var filtredPhotosArray:[UIImage] = []

public func createPhotosArray() {
    for i in photosArray {
        guard let pic = UIImage(named: i) else { return }
        filtredPhotosArray.append(makeFiltredImage(pic))
    }
}

//MARK: For PhotoFilters

func makeFiltredImage(_ image: UIImage) -> UIImage {
    var newImage = UIImage()
    imageProcessor.processImage(sourceImage: image, filter: getRandomFilter(set: filtersSet)) { filteredImage in
        newImage = filteredImage ?? UIImage()
    }
    return newImage
}

// метод для выдачи случайного фотофильтра из представленного массива
func getRandomFilter (set: [ColorFilter]) -> ColorFilter {
    let randomFilterNumber = Int.random(in: 0..<set.count)
    return set[randomFilterNumber]
}
