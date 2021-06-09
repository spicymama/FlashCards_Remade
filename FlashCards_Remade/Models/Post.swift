//
//  RedditPost.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/7/21.
//

import Foundation

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
    let ups: Int
    let thumbnail: String
}
