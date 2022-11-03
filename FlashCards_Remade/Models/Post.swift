//
//  RedditPost.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/7/21.
//

import Foundation
import UIKit

///This model is for a Reddit post

struct PostTopLevelObject: Codable {
    
    let data: PostSecondLevelObject
}

struct PostSecondLevelObject: Codable {
    let children: [PostThirdLevelObject]
}

struct PostThirdLevelObject: Codable {
    let data: Post
    
}

struct Post: Codable {
    let title: String
    let url: String
    let over_18: Bool
    let is_reddit_media_domain: Bool
}


