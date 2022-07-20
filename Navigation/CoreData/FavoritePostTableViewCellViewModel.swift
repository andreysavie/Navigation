////
////  FavoritePostTableViewCellViewModel.swift
////  Navigation
////
////  Created by Андрей Рыбалкин on 19.07.2022.
////
//
//import Foundation
//import UIKit
//
//class FavoritePostTableViewCellViewModel {
//    
//    var post: FavoritePostEntity
//
//        var title: String {
//            return post.title ?? ""
//        }
//    
//        var description: String {
//            return post.text ?? ""
//        }
//    
//        var image: Data {
//            return post.image ?? Data()
//        }
//    
//        var likes: Int {
//            return Int(post.likes)
//        }
//    
//        var views: Int {
//            return Int(post.views)
//        }
//    
//    init(post: FavoritePostEntity) {
//        self.post = post
//    }
//}
