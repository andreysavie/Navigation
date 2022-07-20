//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 24.02.2022.
//

import UIKit
import StorageService
import SnapKit

class PostTableViewCell: UITableViewCell {
    
    // MARK: PROPERTIES
    
    static let identifire = "PostTableViewCell"
    
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
    
    weak var viewModel: PostTableViewCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            postTitle.text = viewModel.title
            postDescription.text = viewModel.description
            postImage.image = UIImage(named: viewModel.image)
            postLikesCounter.text = "Likes: \(viewModel.likes)"
            postViewsCounter.text = "Views: \(viewModel.views)"
        }
    }
    
    
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
