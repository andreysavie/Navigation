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
    
    public func setConfigureOfCell(title: String, image: String, description: String, likes: Int, views: Int) {
        self.postTitle.text = title
        self.postImage.image = UIImage(named: image)
        self.postDescription.text = description
        self.postLikesCounter.text = "Likes: \(likes)"
        self.postViewsCounter.text = "Views: \(views)"
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
    
    // MARK: Constraints
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            
            contentView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            postTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.indent),
            postTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leftMargin),
            postTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.rightMargin),
            
            postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor),
            postImage.topAnchor.constraint(equalTo: postTitle.bottomAnchor, constant: Constants.indent),
            
            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: Constants.indent),
            postDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leftMargin),
            postDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.rightMargin),
            
            postLikesCounter.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: Constants.indent),
            postLikesCounter.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leftMargin),
            postLikesCounter.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.rightMargin),
            
            postViewsCounter.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: Constants.indent),
            postViewsCounter.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.rightMargin),
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
