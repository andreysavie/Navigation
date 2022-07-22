//
//  PostTableViewCellViewModel.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 14.05.2022.
//

import Foundation
import UIKit

class PostTableViewCellViewModel {
    
    var post: Post
    
    
        var title: String {
            return post.title
        }
    
        var description: String {
            return post.description
        }
    
        var image: UIImage {
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
