//
//  CreateCardsViewController.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/2/21.
//

import UIKit

class CreateCardsViewController: UIViewController {
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var deckNameTextField: UITextField!
    @IBOutlet weak var deckNameLabel: UITextField!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var addCardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addStyle()
        self.loadViewIfNeeded()
    }
    
    //MARK: - Functions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let question = questionTextField.text, !question.isEmpty,
              let answer = answerTextField.text, !answer.isEmpty,
              let deck = deckNameTextField.text, !deck.isEmpty
        else {return}
        
        CardController.shared.createCard(question: question, answer: answer, deck: deck) { result in
            DispatchQueue.main.async {
                self.questionTextField.text = ""
                self.answerTextField.text = ""
                self.navigationController?.popViewController(animated: true)
            }
            if !CardController.shared.deckNames.contains(deck) {
                CardController.shared.deckNames.append(deck)
                CardController.shared.deckNames = CardController.shared.deckNames.sorted { $0.lowercased() < $1.lowercased() }
            }
        }
    }
    @IBAction func nextButtonTapped(_ sender: Any) {
        guard let question = questionTextField.text, !question.isEmpty,
              let answer = answerTextField.text, !answer.isEmpty,
              let deck = deckNameTextField.text, !deck.isEmpty
        else {return}
        CardController.shared.createCard(question: question, answer: answer, deck: deck) { result in
            DispatchQueue.main.async {
                self.questionTextField.text = ""
                self.answerTextField.text = ""
            }
        }
    }
    
    func addStyle() {
        deckNameLabel.addCornerRadius()
        questionLabel.addRoundedCorner()
        self.questionLabel.addCornerRadius(5)
        answerLabel.addRoundedCorner()
        questionTextField.addCornerRadius()
        answerTextField.addCornerRadius()
        deckNameTextField.addCornerRadius()
        addCardButton.addCornerRadius()
        deckNameTextField.attributedPlaceholder = NSAttributedString(string: "Deck name here...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}
