//
//  FlashCardViewController.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/2/21.
//

import UIKit
import CloudKit



class FlashCardViewController: UIViewController {
    
    @IBOutlet weak var deckNameLabel: UINavigationItem!
    @IBOutlet weak var questionOrAnswerLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    /*
    var card: Card? {
        didSet {
            randomCard()
            updateViews()
            loadViewIfNeeded()
        }
    }
    
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButtonTapped((Any).self)
        nextButtonTapped((Any).self)

        updateViews()

    }
    var deckToSend: String?
    var currentCard: Card?
    var previousCard: Card?
    var nextCard: Card?
    
    @IBAction func previousButtonTapped(_ sender: Any) {
        self.questionOrAnswerLabel.text = "Question:"
        self.textView.text = "\(previousCard!.question)"
    }
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        randomCard()
        guard let card = currentCard else {return}
        
        self.questionOrAnswerLabel.text = "Question:"
        self.textView.text = "\(card.question)"
    }
    @IBAction func cardTapped(_ sender: Any) {
       flipCard()
        
    }
    
    
    
    func updateViews() {
        guard let card = currentCard else {return}
        DispatchQueue.main.async {
            self.questionOrAnswerLabel.text = "Question:"
            self.textView.text = card.question
            self.title = card.deck
        }
    }
    
    func flipCard() {
        if self.questionOrAnswerLabel.text == "Question:" {
            self.questionOrAnswerLabel.text = "Answer:"
            self.textView.text = currentCard?.answer
        }
        else {
            self.questionOrAnswerLabel.text = "Question:"
            self.textView.text = currentCard?.question
        }
    }
    
    func randomCard()-> Card {
        
        var cards: [Card] = []
        for card in CardController.shared.cards {
            if card.deck == deckToSend && card != previousCard{
                cards.append(card)
            }
            nextCard = cards.randomElement()
            currentCard = nextCard
            previousCard = currentCard
        }
        return currentCard ?? CardController.shared.defaultCard
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
