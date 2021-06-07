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
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let question = questionTextField.text, !question.isEmpty,
              let answer = answerTextField.text, !answer.isEmpty,
              let deck = deckNameTextField.text, !deck.isEmpty
        else {return}
        
        CardController.shared.createCard(question: question, answer: answer, deck: deck) { result in
            DispatchQueue.main.async {
                self.questionTextField.text = ""
                self.answerTextField.text = ""
               // self.dismiss(animated: true, completion: nil)
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
    @IBAction func answerImageButtonTapped(_ sender: Any) {
    }
    @IBAction func questionImageButtonTapped(_ sender: Any) {
    }
    
    
    

}
