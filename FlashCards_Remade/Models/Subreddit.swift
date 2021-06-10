//
//  Subreddit.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/7/21.
//

import Foundation
import CloudKit

struct SubredditTopLevelObject: Codable {
    let data: SubredditSecondLevelObject
}

struct SubredditSecondLevelObject: Codable {
    let children: [SubredditThirdLevelObject]
}

struct SubredditThirdLevelObject: Codable {
    let data: Subreddit
    
}   

struct Subreddit: Codable {
    let display_name_prefixed: String
   
}
