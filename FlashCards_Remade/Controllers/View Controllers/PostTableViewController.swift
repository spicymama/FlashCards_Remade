//
//  FeedTableViewController.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/9/21.
//

import UIKit

class PostTableViewController: UITableViewController {
static let shared = PostTableViewController()

    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPostsForTableView()
        
        timer =  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            if Date() >= PostTableViewController.breakDate {
                timer.invalidate()
                self.timer = nil
                self.navigationController?.popToRootViewController(animated: true)
            }
            print(Date())
            print(PostTableViewController.breakDate)
        }
    }
    
    //MARK: - Properties
    var timer: Timer?
    var posts: [Post] = []
   static var breakDate = Date()
   static var currentDate = Date()
    
    //MARK: - Functions
    func fetchPostsForTableView() {
        PostController.fetchPosts { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self.posts = posts
                    self.tableView.reloadData()
                    self.title = PostController.subs
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell
        let post = posts[indexPath.row]
        cell?.post = post
        return cell ?? UITableViewCell()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 550
    }
}//End of class
