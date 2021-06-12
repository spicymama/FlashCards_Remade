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
            print(Date())
            print(FlashCardViewController.futureDate)
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
                print(Date())
                print(FlashCardViewController.futureDate)
            }
        }
    }
    func addStyle() {
        questionOrAnswerLabel.addCornerRadius()
        textView.addCornerRadius()
        breakTimeButton.addCornerRadius()
        nextButton.addCornerRadius()
        textViewView.addCornerRadius()
    }
    
    @IBAction func breakButtonWasTapped(_ sender: Any) {
        FlashCardViewController.futureDate = Date()
    }
    
    var deckToSend: String?
    var currentCard: Card?
    var previousCard: Card?
    var nextCard: Card?
    var isItBreakTime: Bool = false
    var timer: Timer?
    
    static var futureDate = Date()
    
    @IBAction func previousButtonTapped(_ sender: Any) {
        CardController.shared.deleteCard(card: currentCard ?? CardController.shared.defaultCard) { (result) in
            
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
}
