//
//  SubredditTableViewCell.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/7/21.
//

import UIKit

class SubredditTableViewCell: UITableViewCell {

    @IBOutlet weak var subredditNameLabel: UILabel!
    @IBOutlet weak var iconImage: UIButton!
  
   
    var subreddit: String? {
        didSet {
            updateViews()
            
        }
    }
    
    
    func updateViews() {
       guard let subreddit = subreddit else {return}
        subredditNameLabel.text = "\(subreddit)"
    }

    @IBAction func subredditCellButtonTapped(_ sender: Any) {
      toggleIcon()
        print(StudyGoalTableViewController.shared.selectedSubs)
      //  for sub in PostController.shared.subredditList {
           // if self.iconImage.image(for: .normal) == UIImage(systemName: "checkmark.seal") && selectedSubs.contains(sub) {
             //   self.iconImage.setImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
            //}
       // }
       
    }
    func toggleIcon() {
      
        if iconImage.image(for: .normal) == UIImage(systemName: "checkmark.seal") &&  !StudyGoalTableViewController.shared.selectedSubs.contains(self.textLabel?.text ?? "problem") {
            iconImage.setImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
            StudyGoalTableViewController.shared.selectedSubs.append(self.subreddit ?? "problem")
          
        }
       else if iconImage.image(for: .normal) == UIImage(systemName: "checkmark.seal.fill") &&
                StudyGoalTableViewController.shared.selectedSubs.contains(self.subreddit ?? "problem"){
           iconImage.setImage(UIImage(systemName: "checkmark.seal"), for: .normal)
        guard let index = StudyGoalTableViewController.shared.selectedSubs.firstIndex(of: self.subreddit ?? "problem") else {return}
        StudyGoalTableViewController.shared.selectedSubs.remove(at: index)
        }
   
    }
   
    func fetchIcons() {
        for _ in StudyGoalTableViewController.shared.selectedSubs {
            self.iconImage.setImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
        }
    }
}
