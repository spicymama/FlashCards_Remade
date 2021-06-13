//
//  CreateCardsViewController.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/2/21.
//

import UIKit
import QuartzCore

class CreateCardsViewController: UIViewController {
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerTextView: UITextView!
    
    @IBOutlet weak var deckNameTextField: UITextField!
    @IBOutlet weak var deckNameLabel: UITextField!
    
    @IBOutlet weak var questionLabel: UIButton!
    @IBOutlet weak var answerLabel: UIButton!
    
    
    @IBOutlet weak var addCardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addStyle()
        self.loadViewIfNeeded()
    }
    
    //MARK: - Functions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let question = questionTextView.text, !question.isEmpty,
              let answer = answerTextView.text, !answer.isEmpty,
              let deck = deckNameTextField.text, !deck.isEmpty
        else {return}
        
        CardController.shared.createCard(question: question, answer: answer, deck: deck) { result in
            DispatchQueue.main.async {
                self.questionTextView.text = ""
                self.answerTextView.text = ""
                self.navigationController?.popViewController(animated: true)
            }
            if !CardController.shared.deckNames.contains(deck) {
                CardController.shared.deckNames.append(deck)
                CardController.shared.deckNames = CardController.shared.deckNames.sorted { $0.lowercased() < $1.lowercased() }
            }
        }
    }
    @IBAction func nextButtonTapped(_ sender: Any) {
        guard let question = questionTextView.text, !question.isEmpty,
              let answer = answerTextView.text, !answer.isEmpty,
              let deck = deckNameTextField.text, !deck.isEmpty
        else {return}
        CardController.shared.createCard(question: question, answer: answer, deck: deck) { result in
            DispatchQueue.main.async {
                self.questionTextView.text = ""
                self.answerTextView.text = ""
            }
        }
    }
    
    func addStyle() {
        deckNameLabel.addCornerRadius()
        questionLabel.addCornerRadius(4)
        answerLabel.addCornerRadius(4)
        questionTextView.addCornerRadius()
        answerTextView.addCornerRadius()
        deckNameTextField.addCornerRadius()
        addCardButton.addCornerRadius()
        deckNameTextField.attributedPlaceholder = NSAttributedString(string: "deck name here...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}
