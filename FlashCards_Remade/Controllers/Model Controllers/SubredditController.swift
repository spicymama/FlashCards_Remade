//
//  SubredditController.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/10/21.
//

import UIKit

class SubredditController {
    static let shared = SubredditController()
    
    let subredditList = [ "r/AdviceAnimals", "r/aww", "r/blessedimages", "r/cats", "r/dankmemes", "r/dogpictures", "r/funny", "r/LifeProTips", "r/me_irl", "r/memes", "r/mildlyinteresting", "r/NatureIsFuckingLit", "r/pics", "r/ProgrammerHumor", "r/Showerthoughts", "r/Art", "r/wallpapers", "r/OldSchoolCool", "r/YSK", "r/birdswitharms", "/r/perfecttiming", "/r/itookapicture", "/r/nocontextpics", "/r/pic", "/r/miniworlds", "/r/foundpaper", "/r/images", "/r/screenshots", "/r/damnthatsinteresting", "/r/ColorizedHistory", "/r/colorization", "/r/HybridAnimals", "/r/Foodforthought", "/r/todayilearned", "/r/drawing", "r/pixelart", "/r/illustration", "/r/historymemes", "r/thatHappened", "r/wholesomememes", "/r/wholesomeanimemes", "/r/webcomics", "/r/comics", "/r/lotrmemes", "/r/cosplay", "/r/lego", "/r/starwars", "/r/prequelmemes", "/r/SequelMemes", "/r/facepalm", "/r/insanepeoplefacebook", "/r/tumblrinaction", "/r/blackpeopletwitter", "/r/WhitePeopleTwitter", "/r/moviedetails", "r/batman", "r/nba", "r/nhl", "r/nfl", "r/nflmemes", "r/BikiniBottomTwitter", "/r/woodworking", "/r/glitch_art", "/r/brandnewsentence", "/r/dontdeadopeninside", "/r/photography", "/r/suspiciouslyspecific", "/r/rarepuppers", "/r/garlicbreadmemes", "/r/2meirl4meirl", "/r/woof_irl", "/r/meow_irl", "/r/absolutelynotme_irl"].sorted { $0.lowercased() < $1.lowercased() }
}
