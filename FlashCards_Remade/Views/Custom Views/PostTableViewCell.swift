//
//  PostTableViewCell.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/9/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    var post: Post? {
        didSet {
            updateViews()
            postImageView.addCornerRadius()
            postTitleLabel.addCornerRadius()
        }
    }
    
    //MARK: - Functions
    func updateViews() {
        
        guard let post = post else {return}
        
        postTitleLabel.text = ".\n.\n\(post.title)\n.\n."
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
