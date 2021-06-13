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
    
    @IBOutlet weak var troubleLoadingImageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var postImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPostsForTableView()
        nextButton.addRoundedCorner()
      //  postImageView.addCornerRadius()
        self.postImageView.layer.cornerRadius = self.postImageView.frame.width/12.0
        
        timer =  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            if Date() >= PostFeedViewController.breakDate {
                self.navigationController?.popToRootViewController(animated: true)
                self.timer?.invalidate()
                self.timer = nil
                PostFeedViewController.breakDate = Date()
                PostFeedViewController.currentDate = Date()
                FlashCardViewController.shared.timer =  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    FlashCardViewController.shared.timer = timer
                }
            }
            print(Date())
            print(PostFeedViewController.breakDate)
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        updateViews()
    }
    
    //MARK: - Properties
    var timer: Timer?
    var posts: [Post] = []
    
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
                    self.troubleLoadingImageLabel.isHidden = true
                    
                    
                case .failure(let error):
                    self.troubleLoadingImageLabel.isHidden = false
                    self.postImageView.image = nil
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
}
