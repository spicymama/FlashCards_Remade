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
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
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
            print(CardController.shared.deckNames)
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
        print(CardController.shared.deckNames.count)
        setupViews()
        return CardController.shared.deckNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "deckCell", for: indexPath) as? DeckNameTableViewCell else {return UITableViewCell()}
        setupViews()
        let deck = CardController.shared.deckNames.sorted { $0.lowercased() < $1.lowercased() }[indexPath.item]
        cell.deck = deck
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var cardsToDelete: [Card] = []
            for card in CardController.shared.cards {
                if card.deck == CardController.shared.deckNames[indexPath.row] {
                    cardsToDelete.append(card)
                }
            }
            for card in cardsToDelete {
                let index = CardController.shared.deckNames.firstIndex(of: card.deck) ?? 0
                CardController.shared.deleteDeck(card: card) { (result) in
                    
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let success):
                            print(success)
                            if cardsToDelete.count == 0 && CardController.shared.deckNames.contains(card.deck) {
                                CardController.shared.deckNames.remove(at: index)
                                self.tableView.deleteRows(at: [indexPath], with: .fade)
                                self.setupViews()
                            }
                        case .failure(let error):
                            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                        }
                    }
                }
            }
            self.loadData()
        }
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCardVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? FlashCardViewController else {return}
            let deckToSend = CardController.shared.deckNames.sorted { $0.lowercased() < $1.lowercased() }[indexPath.row]
            destinationVC.deckToSend = deckToSend
        }
    }
}
