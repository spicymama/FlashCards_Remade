//
//  StudyGoalTableViewController.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/7/21.
//

import UIKit

class SubredditTableViewController: UITableViewController {
    static let shared = SubredditTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PostFeedViewController.shared.timer =  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SubredditController.shared.subredditList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "subredditCell", for: indexPath) as? SubredditTableViewCell else {return UITableViewCell()}
        let subreddit = SubredditController.shared.subredditList[indexPath.row]
        cell.subreddit = subreddit
        
        return cell
    }
}
