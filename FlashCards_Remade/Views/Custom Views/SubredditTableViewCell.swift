//
//  SubredditTableViewCell.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/7/21.
//

import UIKit

protocol SubredditTableViewCellDelegate: AnyObject {
    func cellWasSelected(_ sender: SubredditTableViewCell)
}

class SubredditTableViewCell: UITableViewCell {

    @IBOutlet weak var subredditNameLabel: UILabel!
    @IBOutlet weak var iconImage: UIButton!
    
    
  
    var subreddit: String? {
        didSet {
            updateViews()
            
        }
    }
    
    weak var delegate: SubredditTableViewCellDelegate?
    private var cellTapped: Bool = false
    
    func updateViews() {
       guard let subreddit = subreddit else {return}
        subredditNameLabel.text = "\(subreddit)"
        /*
        
        cellTapped ? iconImage.setImage(selected, for: .normal) : iconImage.setImage(unselected, for: .normal)
            */
        
    }

    @IBAction func subredditCellButtonTapped(_ sender: Any) {
        toggleIcon()
        print("button works")
    }
    func toggleIcon() {
        let selected = UIImage(named: "checkmark.seal.fill")
        let unselected = UIImage(named: "checkmark.seal")
       // if iconImage.imageView?.image == selected {
           // iconImage.setImage(unselected, for: .normal)
       // }
      //  else if iconImage.imageView?.image == unselected {
            iconImage.setImage(selected, for: .normal)
        //}
    }
    
}
