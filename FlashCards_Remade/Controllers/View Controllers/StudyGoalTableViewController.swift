//
//  StudyGoalTableViewController.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/7/21.
//

import UIKit

class StudyGoalTableViewController: UITableViewController {
static let shared = StudyGoalTableViewController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
      fetchSubreddits()
        print(selectedSubs)
    }
  
    var subreddits: [String] = []
    var selectedSubs: [String] = []
   
    func fetchSubreddits() {
        PostController.fetchSubreddits { (result) in
        DispatchQueue.main.async {
            switch result {
            case .success(let subreddits):
                self.subreddits = subreddits
                self.tableView.reloadData()
            case .failure(let error):
                 print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    
   
 
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subreddits.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "subredditCell", for: indexPath) as? SubredditTableViewCell else {return UITableViewCell()}
     
        let subreddit = subreddits[indexPath.row]
        cell.subreddit = subreddit
       // cell.textLabel?.text = subreddit
       
        return cell
    }
}
/*
extension StudyGoalTableViewController: SubredditTableViewCellDelegate {
    func cellWasSelected(_ sender: SubredditTableViewCell) {
        guard let subreddit = sender.subreddit else {return}
        selectedSubs.append(subreddit)
        sender.updateViews()
       
    }
 
}
*/
