//
//  FeedTableViewController.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 5/7/22.
//

import UIKit
/*
class FeedTableViewController: UITableViewController {
    var refresh: UIRefreshControl = UIRefreshControl()
    static let shared = FeedTableViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPostsForTableView()
        loadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? FeedTableViewCell else {return UITableViewCell()}
        cell.post = posts[indexPath.row]
        
        return cell
    }
    
    var finPosts: [(title: Post, postImage: UIImage)] = []
    var posts: [Post] = []
    
    func fetchPostsForTableView() {
        PostController.fetchPosts { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self.posts = posts
                   // self.updateViews()
                    
                    
                    self.title = PostController.subs
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
            
        }
    }
    
    func loadData() {
         DispatchQueue.main.async {
             self.tableView.reloadData()
             self.refresh.endRefreshing()
         }
     }
    
    /*
    func updateViews() {
        guard let post = posts.first else {return}
        for post in posts {
        PostController.fetchThumbNail(post: post) { (result) in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let thumbnail):
                    
                    print(post.title)
                    self.finPosts.append((post, thumbnail))
                    self.posts.remove(at: 0)
                    
                    /*
                    self.titleLabel.text = "\(post.title)"
                    self.postImageView.image = thumbnail
                    self.troubleLoadingImageLabel.isHidden = true
                    print(post.title)
                    print(post.over_18)
                    print(post.url)
                    */
                    
                case .failure(let error):
                   
                    /*
                    self.postImageView.image = nil
                    self.titleLabel.text = ""
                    self.troubleLoadingImageLabel.isHidden = false
                    self.updateViews()
                    self.troubleLoadingImageLabel.isHidden = false
                    self.postImageView.image = nil
                     */
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    self.posts.remove(at: 0)
                }
            }
            }
            self.loadData()
        }
        print(finPosts.count)
    }
            */

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
}
*/
