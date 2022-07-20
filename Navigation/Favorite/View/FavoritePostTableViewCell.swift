//
//  FavoritePostTableViewCell.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 19.07.2022.
//

import Foundation
import UIKit
import StorageService
import SnapKit

class FavoritePostTableViewCell: UITableViewCell {
    
    // MARK: PROPERTIES
    
    static let identifire = "FavoritePostTableViewCell"
    
    private lazy var postTitle: UILabel = {
        
        let postTitle = UILabel()
        postTitle.numberOfLines = 2
        postTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return postTitle
    }()
    
    private lazy var postImage: UIImageView = {
        
        let postImage = UIImageView()
        postImage.backgroundColor = .black
        postImage.contentMode = .scaleAspectFit
        return postImage
    }()
    

    private lazy var postDescription: UILabel = {
        
        let postDescription = UILabel()
        postDescription.font = UIFont.systemFont(ofSize: 14)
        postDescription.textColor = .systemGray
        postDescription.numberOfLines = 0
        return postDescription
    }()
    
    private lazy var postLikesCounter: UILabel = {
        let counter = UILabel()
        counter.font = UIFont.systemFont(ofSize: 16)
        counter.textColor = .black
        return counter
    }()
    
    private lazy var postViewsCounter: UILabel = {
        let counter = UILabel()
        counter.font = UIFont.systemFont(ofSize: 16)
        counter.textColor = .black
        return counter
    }()
    
    // MARK: INITS
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(
            postTitle,
            postImage,
            postDescription,
            postLikesCounter,
            postViewsCounter
        )
        setupPostLayout()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: METHODS
        
    public func configureOfCell (_ post: FavoritePostEntity) {
        self.postTitle.text = post.title ?? ""
        self.postImage.image = UIImage(data: post.image!) ?? UIImage()
        self.postDescription.text = post.text ?? ""
        self.postLikesCounter.text = "Likes: \(Int(post.likes))"
        self.postViewsCounter.text = "Views: \(Int(post.views))"
    }
    
    private func setupPostLayout(){
        
        postTitle.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(contentView).inset(Constants.margin)
        }
        
        postImage.snp.makeConstraints { make in
            make.width.height.equalTo(contentView.snp.width)
            make.top.equalTo(postTitle.snp.bottom).offset(Constants.margin)
        }
        
        postDescription.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(Constants.margin)
            make.leadingMargin.trailing.equalTo(contentView).inset(Constants.margin)
        }
        
        postLikesCounter.snp.makeConstraints { make in
            make.top.equalTo(postDescription.snp.bottom).offset(Constants.margin)
            make.leading.bottom.equalTo(contentView).inset(Constants.margin)
        }
        
        postViewsCounter.snp.makeConstraints { make in
            make.top.equalTo(postDescription.snp.bottom).offset(Constants.margin)
            make.trailing.bottom.equalTo(contentView).inset(Constants.margin)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

