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
        
    }
    var selectedSubs: [String] = []
    var subreddits: [String] = [].sorted { $0.lowercased() < $1.lowercased() }
    var unselectedSubs: [String] = []
   
    func fetchSubreddits() {
        PostController.fetchSubreddits { (result) in
        DispatchQueue.main.async {
            switch result {
            case .success(let subreddits):
                self.subreddits = subreddits.sorted { $0.lowercased() < $1.lowercased() }
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
       
       
        return cell
    }
 
}
