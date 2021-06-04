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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadViewIfNeeded()

    }
   
    //MARK: - Functions
    
    @IBAction func doneButtonTapped(_ sender: Any) {
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
        if !CardController.shared.deckNames.contains(deck) {
            CardController.shared.deckNames.append(deck)
        self.navigationController?.popViewController(animated: true)
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
        if !CardController.shared.deckNames.contains(deck) {
            CardController.shared.deckNames.append(deck)
        }
    }
    @IBAction func answerImageButtonTapped(_ sender: Any) {
    }
    @IBAction func questionImageButtonTapped(_ sender: Any) {
    }
    
    
    

}
