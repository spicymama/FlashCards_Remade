//
//  PostFeedViewController.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/12/21.
//

import UIKit
import YouTubePlayer
import AVKit


class PostFeedViewController: UIViewController, YouTubePlayerDelegate, AVPlayerViewControllerDelegate {
    static let shared = PostFeedViewController()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var troubleLoadingImageLabel: UILabel!
    @IBOutlet weak var GFYCatView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var playerView: YouTubePlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        troubleLoadingImageLabel.isHidden = false
        fetchPostsForTableView()
        
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
        }
        updateViews()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        playerView.isHidden = true
        self.postImageView.stopAnimating()
        self.postImageView.animationImages = []
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
        guard let post = posts.first else {return}
        print("FUNC MIMETYPE: \(PostController.mimeTypeForPath(path: post.url))")
        if post.url.contains("youtube") || post.url.contains("youtu.be")  {
            loadVideo(url: post.url)
            self.playerView.isHidden = false
            self.GFYCatView.isHidden = true
            self.troubleLoadingImageLabel.isHidden = true
            self.postImageView.isHidden = true
            self.titleLabel.text = post.title
            self.posts.remove(at: 0)
            if self.posts.count == 0 {
                self.fetchPostsForTableView()
            }
            
        } else if PostController.mimeTypeForPath(path: post.url).contains("gif") {
            self.playerView.isHidden = true
            self.postImageView.isHidden = false
            self.GFYCatView.isHidden = true
            self.troubleLoadingImageLabel.isHidden = true
            self.titleLabel.text = post.title
            loadRedditGif(url: post.url)
            self.posts.remove(at: 0)
            if self.posts.count == 0 {
                self.fetchPostsForTableView()
            }
        } else if PostController.mimeTypeForPath(path: post.url).contains("image") {
            PostController.fetchThumbNail(post: post) { (result) in
                
                DispatchQueue.main.async {
                    
                    switch result {
                    case .success(let thumbnail):
                        self.GFYCatView.isHidden = true
                        self.playerView.isHidden = true
                        self.postImageView.isHidden = false
                        self.troubleLoadingImageLabel.isHidden = true
                        self.titleLabel.text = "\(post.title)"
                        self.postImageView.image = thumbnail
                        
                    case .failure(let error):
                        print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                        self.postImageView.image = nil
                        self.troubleLoadingImageLabel.isHidden = false
                    }
                }
                self.posts.remove(at: 0)
                if self.posts.count == 0 {
                    self.fetchPostsForTableView()
                }
            }
        } else if PostController.mimeTypeForPath(path: post.url).contains("mp4") || PostController.mimeTypeForPath(path: post.url).contains("video") || self.titleLabel.text!.contains("video") {
            self.playerView.isHidden = true
            self.postImageView.isHidden = true
            self.GFYCatView.isHidden = false
            self.troubleLoadingImageLabel.isHidden = true
            self.titleLabel.text = post.title
            loadGifAVView(url: post.url)
        } else {
            self.troubleLoadingImageLabel.isHidden = false
            self.posts.remove(at: 0)
            updateViews()
        }
    }
    func loadRedditGif(url: String) {
        let gifImageView = self.postImageView
        guard let url = URL(string: url) else {return}
        
        DispatchQueue.global(qos: .userInteractive).async {
            guard let gifData = try? Data(contentsOf: url),
                  let source =  CGImageSourceCreateWithData(gifData as CFData, nil) else { return }
            var images = [UIImage]()
            let imageCount = CGImageSourceGetCount(source)
            print(images.count)
            for i in 0 ..< imageCount {
                if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                    images.append(UIImage(cgImage: image))
                }
            }
            DispatchQueue.main.async {
                gifImageView?.animationImages = images
                if gifImageView?.animationImages?.count != 0 {
                    gifImageView?.startAnimating()
                    return
                }
            }
        }
    }
    func loadGifAVView(url: String) {
        guard let url = URL(string: url) else {return}
        DispatchQueue.global(qos: .userInteractive).async {
            let player = AVPlayer(url: url)
            let vc = AVPlayerViewController()
            DispatchQueue.main.async {
            self.GFYCatView.addSubview(vc.view)
            vc.view.frame = self.GFYCatView.bounds
            vc.player = player
            vc.showsPlaybackControls = false
            vc.player?.play()
            }
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { [weak player] _ in
                player?.seek(to: CMTime.zero)
                vc.player?.play()
            }
        }
    }
    func loadVideo(url: String) {
        guard let vidURL = URL(string: url) else {return}
        DispatchQueue.global(qos: .userInteractive).async {
            self.playerView.delegate = self
            DispatchQueue.main.async {
                self.playerView.loadVideoURL(vidURL)
            self.playerView.clipsToBounds = true
            self.playerView.frame = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 415, height: 500)
                if self.playerView.ready == true {
                    self.playerView.play()
                }
            }
        }
    }
}

