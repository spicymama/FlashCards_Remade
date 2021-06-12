//
//  SubredditController.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/10/21.
//

import UIKit

class SubredditController {
    static let shared = SubredditController()
    
    let subredditList = [ "r/AdviceAnimals", "r/aww", "r/blessedimages", "r/cats", "r/dankmemes", "r/dogpictures", "r/funny", "r/LifeProTips", "r/me_irl", "r/memes", "r/mildlyinteresting", "r/NatureIsFuckingLit", "r/pics", "r/ProgrammerHumor", "r/Showerthoughts", "r/Art", "r/WTF", "r/FoodPorn", "r/wallpapers", "r/OldSchoolCool", "r/YSK", "r/anime", "r/birdswitharms"].sorted { $0.lowercased() < $1.lowercased() }
}
