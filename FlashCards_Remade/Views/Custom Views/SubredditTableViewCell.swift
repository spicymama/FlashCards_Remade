//
//  SubredditTableViewCell.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/7/21.
//

import UIKit

class SubredditTableViewCell: UITableViewCell {

    var subreddit: String? {
        didSet {
            updateViews()
            
        }
    }
    
    
    func updateViews() {
       guard let subreddit = subreddit else {return}
        self.textLabel?.text = "\(subreddit)"
    }

    @IBAction func subredditCellButtonTapped(_ sender: Any) {
        PostController.subs = self.textLabel?.text ?? "r/memes"
       // PostTableViewController.shared.fetchPostsForTableView()
    
       
        
        print("button works")
    }
}
