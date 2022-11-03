//
//  FeedTableViewCell.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 5/7/22.
//

import UIKit
import AVKit
import AVFoundation
/*
class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    let vc = FeedTableViewController()
    var post: Post? {
        didSet {
            guard let post = post else {return}
           
                PostController.fetchThumbNail(post: post) { (result) in
                    DispatchQueue.main.async {
                        
                        switch result {
                        case .success(let thumbnail):
                            
                            guard let url = URL(string: post.url) else {return}
                            self.titleLabel.text = post.title
                            let player = AVPlayer(url: url)

                                let playerLayer = AVPlayerLayer(player: player)
                                playerLayer.frame = self.postImageView.bounds
                                self.postImageView.layer.addSublayer(playerLayer)
                                player.play()

                            self.postImageView.image = thumbnail
                           
                        case .failure(let error):
                            self.titleLabel.text = post.title
                            self.postImageView?.image = nil
                            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    }
                    }
                }
            FeedTableViewController.shared.loadData()
        }
        
    }

}
*/
