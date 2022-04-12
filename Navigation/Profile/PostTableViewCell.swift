//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 24.02.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    static let identifire = "PostTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(postTitle, postImage, postDescription, postLikesCounter, postViewsCounter)
        setupConstraints()
    }
    
    
    private lazy var postTitle: UILabel = {
        
        let postTitle = UILabel()
        postTitle.toAutoLayout()
        postTitle.numberOfLines = 2
        postTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return postTitle
    }()
    
    private lazy var postImage: UIImageView = {
        
        let postImage = UIImageView()
        postImage.toAutoLayout()
        postImage.backgroundColor = .black
        postImage.contentMode = .scaleAspectFit
        return postImage
    }()
    

    private lazy var postDescription: UILabel = {
        
        let postDescription = UILabel()
        postDescription.toAutoLayout()
        postDescription.font = UIFont.systemFont(ofSize: 14)
        postDescription.textColor = .systemGray
        postDescription.numberOfLines = 0
        return postDescription
    }()
    
    private lazy var postLikesCounter = counter()
    private lazy var postViewsCounter = counter()

    private func counter() -> UILabel {
        
        let counter = UILabel()
        counter.toAutoLayout()
        counter.font = UIFont.systemFont(ofSize: 16)
        counter.textColor = .black
        return counter
    }
    
    public func setConfigureOfCell(post: Post) {
        self.postTitle.text = post.title
        self.postDescription.text = post.description
        self.postImage.image = UIImage(named: post.image)
        self.postLikesCounter.text = "Likes: \(post.likes)"
        self.postViewsCounter.text = "Views: \(post.views)"
    }
    
    // MARK: Constraints
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            
            contentView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            postTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.indent),
            postTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMargin),
            postTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingMargin),
            
            postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor),
            postImage.topAnchor.constraint(equalTo: postTitle.bottomAnchor, constant: Constants.indent),
            
            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: Constants.indent),
            postDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMargin),
            postDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingMargin),
            
            postLikesCounter.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: Constants.indent),
            postLikesCounter.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMargin),
            postLikesCounter.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.trailingMargin),
            
            postViewsCounter.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: Constants.indent),
            postViewsCounter.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingMargin),
            postViewsCounter.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.indent),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
