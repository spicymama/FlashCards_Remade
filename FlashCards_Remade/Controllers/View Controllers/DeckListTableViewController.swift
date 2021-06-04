//
//  DeckListTableViewController.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/2/21.
//

import UIKit

class DeckListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadData()
        tableView.reloadData()
        
    }
    var refresh: UIRefreshControl = UIRefreshControl()
    
    func setupViews() {
        refresh.attributedTitle = NSAttributedString(string: "Pull to load")
        refresh.addTarget(self, action: #selector(loadData), for: .valueChanged)
        tableView.addSubview(refresh)

    }
    func updateViews() {
        DispatchQueue.main.async {
            self.refresh.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    @objc func loadData() {
        CardController.shared.fetchCards { (result) in
            switch result {
            case .success(let card):
                guard let card = card else {return}
                CardController.shared.cards = card
                self.updateViews()
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CardController.shared.deckNames.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "deckCell", for: indexPath) as? DeckNameTableViewCell else {return UITableViewCell()}
        
        let deck = CardController.shared.deckNames[indexPath.row]
        cell.deck = deck
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deckToDelete = CardController.shared.deckNames[indexPath.row]
            var cardsToDelete: [Card] = []
            for card in CardController.shared.cards {
                if card.deck == CardController.shared.cards[indexPath.row].deck {
                    cardsToDelete.append(card)
                }
            }
            guard let index = CardController.shared.deckNames.firstIndex(of: deckToDelete) else {return}
            CardController.shared.deckNames.remove(at: index)
            for cardToDelete in cardsToDelete {
                CardController.shared.deleteCard(card: cardToDelete) { (result) in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let success):
                            print(success)
                               
                        case .failure(let error):
                             print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                        }
                    }
                }
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }    
    }
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCardVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? FlashCardViewController else {return}
            if CardController.shared.cards[indexPath.row].deck == CardController.shared.deckNames[indexPath.row] {
            let cardToSend = CardController.shared.cards[indexPath.row]
            
            destinationVC.currentCard = cardToSend
            }
        }
    }
}
