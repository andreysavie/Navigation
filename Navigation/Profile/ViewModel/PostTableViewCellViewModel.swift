//
//  PostTableViewCellViewModel.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 14.05.2022.
//

import Foundation
import UIKit

class PostTableViewCellViewModel: PostTableViewCellViewModelType {
    
    var post: Post
    
        var author: String {
            return post.author
        }
    
        var title: String {
            return post.title
        }
    
        var description: String {
            return post.description
        }
    
        var image: String {
            return post.image
        }
    
        var likes: Int {
            return post.likes
        }
    
        var views: Int {
            return post.views
        }
    
    init(post: Post) {
        self.post = post
    }
}


//
//
//
    
//    self.postTitle.text = post.title
//    self.postDescription.text = post.description
//    self.postImage.image = UIImage(named: post.image)
//    self.postLikesCounter.text = "Likes: \(post.likes)"
//    self.postViewsCounter.text = "Views: \(post.views)"

//var postTitle: UILabel {
//        let postTitle = UILabel()
//        postTitle.text = post.title
//        postTitle.numberOfLines = 2
//        postTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//        return postTitle
//    }
//
//    var postImage: UIImageView {
//        let postImage = UIImageView()
//        postImage.image = UIImage(named: post.image)
//        postImage.backgroundColor = .black
//        postImage.contentMode = .scaleAspectFit
//        return postImage
//    }
//
//    var postDescription: UILabel {
//        let postDescription = UILabel()
//        postDescription.text = post.description
//        postDescription.font = UIFont.systemFont(ofSize: 14)
//        postDescription.textColor = .systemGray
//        postDescription.numberOfLines = 0
//        return postDescription
//    }
//
//    var postLikesCounter: UILabel {
//        let counter = UILabel()
//        counter.text = "Likes: \(post.likes)"
//        counter.font = UIFont.systemFont(ofSize: 16)
//        counter.textColor = .black
//        return counter
//    }
//
//    var postViewsCounter: UILabel {
//        let counter = UILabel()
//        counter.text = "Posts: \(post.views)"
//        counter.font = UIFont.systemFont(ofSize: 16)
//        counter.textColor = .black
//        return counter
//    }
