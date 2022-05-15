//
//  PostTableViewCellViewModelType.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 14.05.2022.
//

import Foundation
import UIKit

// MARK: Model type of tableView cell

protocol PostTableViewCellViewModelType: AnyObject {
    
    var author: String { get }
    var title: String { get }
    var description: String { get }
    var image: String { get }
    var likes: Int { get }
    var views: Int { get }
    
}
    
//    var postTitle: UILabel { get }
//
//    var postImage: UIImageView { get }
//
//    var postDescription: UILabel { get }
//
//    var postLikesCounter: UILabel { get }
//
//    var postViewsCounter: UILabel { get }
    


//    var fullName: String { get }
//    var age: String { get }
    
//    private var post: Post
