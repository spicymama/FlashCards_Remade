//
//  Subreddit.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/7/21.
//

import Foundation

struct SubredditTopLevelObject: Codable {
    let data: SubredditSecondLevelObject
}

struct SubredditSecondLevelObject: Codable {
    let children: [SubredditThirdLevelObject]
}

struct SubredditThirdLevelObject: Codable {
    let data: Subreddit
    
}
//struct SubredditFourthLevelObject: Codable {
   

struct Subreddit: Codable {
    let display_name_prefixed: String
}
