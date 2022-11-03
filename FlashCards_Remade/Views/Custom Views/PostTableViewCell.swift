//
//  PostTableViewCell.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/9/21.
//

import UIKit
/*
class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    var post: Post? {
        didSet {
            updateViews()
            postImageView.addCornerRadius()
        }
    }
    
    //MARK: - Functions
    func updateViews() {
        
        guard let post = post else {return}
        
        PostController.fetchThumbNail(post: post) { (result) in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let thumbnail):
                    self.postImageView.image = thumbnail
                    self.postImageView.sizeToFit()
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
}
*/
