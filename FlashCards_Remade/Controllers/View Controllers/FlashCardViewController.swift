//
//  FlashCardViewController.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/2/21.
//

import UIKit
import CloudKit



class FlashCardViewController: UIViewController {
    static let shared = FlashCardViewController()
    @IBOutlet weak var deckNameLabel: UINavigationItem!
    @IBOutlet weak var questionOrAnswerLabel: UILabel!
    @IBOutlet weak var textViewView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var breakTimeButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButtonTapped((Any).self)
        nextButtonTapped((Any).self)
        deckNameLabel.title = currentCard.deck
        breakTimeButton.isHidden = true
        updateViews()
        addStyle()
        timer =  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            if Date()  >= FlashCardViewController.futureDate {
                timer.invalidate()
                self.timer = nil
                self.breakTimeButton.isHidden = false
                if Date() < FlashCardViewController.futureDate {
                    self.breakTimeButton.isHidden = true
                }
            }
        }
        func viewDidAppear(animated: Bool) {
            super.viewDidAppear(true)
            breakTimeButton.isHidden = true
            self.timer =  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
                if Date()  >= FlashCardViewController.futureDate {
                    timer.invalidate()
                    self.timer = nil
                    self.breakTimeButton.isHidden = false
                    if Date()  < FlashCardViewController.futureDate {
                        self.breakTimeButton.isHidden = true
                    }
                }
            }
        }
    }
    
    
    func addStyle() {
        questionOrAnswerLabel.layer.masksToBounds = true
        questionOrAnswerLabel.layer.cornerRadius = 15
        textView.addCornerRadius()
        breakTimeButton.addCornerRadius()
        nextButton.addCornerRadius()
        textViewView.addCornerRadius()
    }
    
    @IBAction func breakButtonWasTapped(_ sender: Any) {
        FlashCardViewController.futureDate = Date()
    }
    
    var deckToSend: String?
    var currentCard: Card = CardController.shared.defaultCard
    var previousCard: Card = CardController.shared.defaultCard
    var nextCard: Card = CardController.shared.defaultCard
    var isItBreakTime: Bool = false
    var timer: Timer?
    
    static var futureDate = Date()
    
    @IBAction func previousButtonTapped(_ sender: Any) {
        CardController.shared.deleteCard(card: currentCard ) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let success):
                    print(success)
                    self.nextButtonTapped(success)
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
        self.updateViews()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        randomCard()
        let card = currentCard
        self.questionOrAnswerLabel.text = "Question:"
        self.textView.text = "\(card.question)"
    }
    
    @IBAction func cardTapped(_ sender: Any) {
        flipCard()
    }
    
    func updateViews() {
        let card = currentCard
        DispatchQueue.main.async {
            self.questionOrAnswerLabel.text = "Question:"
            self.textView.text = card.question
            self.title = card.deck
        }
    }
    
    func flipCard() {
        if self.questionOrAnswerLabel.text == "Question:" {
            self.questionOrAnswerLabel.text = "Answer:"
            self.textView.text = currentCard.answer
        }
        else {
            self.questionOrAnswerLabel.text = "Question:"
            self.textView.text = currentCard.question
        }
    }
    
    func randomCard()-> Void {
        var cards: [Card] = []
        var usedCards: [Card] = []
        for card in CardController.shared.cards {
            if card.deck == deckToSend && card != previousCard{
                cards.append(card)
            }
            if cards != [] {
                nextCard = cards[0]
                previousCard = currentCard
                currentCard = nextCard
                guard let index = cards.firstIndex(of: previousCard ) else {return}
                usedCards.append(previousCard )
                cards.remove(at: index)
            }
            if cards == [] {
                cards.append(contentsOf: usedCards)
                usedCards = []
            }
        }
        return
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editDeck" {
            guard let destinationVC = segue.destination as? CreateCardsViewController else {return}
            destinationVC.deckName = currentCard.deck
        }
    }
}

