//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 24.02.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    private lazy var postNameLabel: UILabel = {
        
        let postNameLabel = UILabel()
        postNameLabel.toAutoLayout()
        postNameLabel.text = post_1.title
        postNameLabel.textColor = .black
        postNameLabel.backgroundColor = .white
        postNameLabel.numberOfLines = 2
        postNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return postNameLabel
        
    }()
    
    private lazy var postImage: UIImageView = {
        
        let postImage = UIImageView()
        
        postImage.toAutoLayout()
        
        postImage.image = UIImage(named: "post_1")
        postImage.backgroundColor = .black
        postImage.contentMode = .scaleAspectFit
        
        return postImage
        
    }()
    
    private lazy var postDescription: UITextView = {
        
        let postDescription = UITextView()
        
        postDescription.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        postDescription.textColor = .systemGray
        postDescription.textContainer.maximumNumberOfLines = 0
        
        return postDescription
        
    }()
    
    private lazy var likesCounter = counter(title: "Likes", count: 125)
    private lazy var ViewsCounter = counter(title: "Views", count: 500)
    
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            postNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            postNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            
            postImage.topAnchor.constraint(equalTo: postNameLabel.bottomAnchor),
            postImage.widthAnchor.constraint(equalTo: self.widthAnchor),
            postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor),
            
            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
            postDescription.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            postDescription.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            postDescription.bottomAnchor.constraint(equalTo: likesCounter.topAnchor, constant: 20),
            
            likesCounter.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            likesCounter.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),

            ViewsCounter.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            ViewsCounter.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
        
        ])
    }

//    private lazy var likesCounter: UILabel = {
//
//        let likesCounter = UILabel()
//
//        return likesCounter
//
//    }()

    
    
    private func counter (title: String, count: Int) ->  UILabel {
        
        let counter = UILabel()
        
        counter.toAutoLayout()
        
        counter.text = "\(title): \(count)"
        counter.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        counter.textColor = .black
        
        return counter
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}
