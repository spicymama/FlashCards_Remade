//
//  PostFeedViewController.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/12/21.
//

import UIKit

class PostFeedViewController: UIViewController {
    static let shared = PostFeedViewController()
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var postImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPostsForTableView()
        titleLabel.addRoundedCorner()
        nextButton.addRoundedCorner()
        postImageView.addRoundedCorner()
        
        timer =  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            if Date() >= PostTableViewController.breakDate {
                self.navigationController?.popToRootViewController(animated: true)
                self.timer?.invalidate()
                self.timer = nil
                PostTableViewController.breakDate = Date()
                PostTableViewController.currentDate = Date()
                FlashCardViewController.shared.timer =  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    FlashCardViewController.shared.timer = timer
                }
            }
            print(Date())
            print(PostTableViewController.breakDate)
        }

    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        updateViews()
    }
    @IBAction func previousButtonTapped(_ sender: Any) {
    }
    
    //MARK: - Properties
    var timer: Timer?
    var posts: [Post] = []
    var count = 0
   static var breakDate: Date = Date()
   static var currentDate = Date()
    
    //MARK: - Functions
    func fetchPostsForTableView() {
        PostController.fetchPosts { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self.posts = posts
                    self.updateViews()
                   
                   
                    self.title = PostController.subs
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
  
    func updateViews() {
        guard let post = posts.randomElement() else {return}
        titleLabel.text = "\(post.title)"
        PostController.fetchThumbNail(post: post) { (result) in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let thumbnail):
                    self.postImageView.image = thumbnail
                   
                   
                case .failure(let error):
                    self.postImageView.image = UIImage(named: "ImageNotAvailible")
                     print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
}
