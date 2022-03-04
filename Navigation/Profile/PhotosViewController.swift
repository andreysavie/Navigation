//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 03.03.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    private let photos = ["pic_1", "pic_2", "pic_3", "pic_4", "pic_5", "pic_6", "pic_7", "pic_8", "pic_9", "pic_10", "pic_11", "pic_12", "pic_13", "pic_14", "pic_15", "pic_16", "pic_17", "pic_18", "pic_19", "pic_20"]
    
    let itemsPerRow: CGFloat = 3
    let sectionInserts = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(
            SecondCustomCell.self,
            forCellWithReuseIdentifier: String(describing: SecondCustomCell.self))
        
        collection.dataSource = self
        collection.delegate = self
        
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SecondCustomCell.self), for: indexPath) as? SecondCustomCell else { return UICollectionViewCell() }
        cell.configure(with: photos[indexPath.item])
        return cell
    }
  
    
}
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
}


final class SecondCustomCell: UICollectionViewCell {
    
    private let photo: UIImageView = {
        let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.contentMode = .scaleAspectFit
        return photo
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupCellContent()
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellContent() {
        contentView.addSubview(photo)
        
        NSLayoutConstraint.activate([
            photo.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            photo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func configure(with photoName: String) {
        photo.image = UIImage(named: photoName)
    }
}
