//
//  DeckNameTableViewCell.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/3/21.
//

import UIKit

class DeckNameTableViewCell: UITableViewCell {

    @IBOutlet weak var deckNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var deck: String? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let deck = deck else {return}
        deckNameLabel.text = "\(deck)"
    }
}
