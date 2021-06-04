//
//  FlashCardViewController.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/2/21.
//

import UIKit
import CloudKit



class FlashCardViewController: UIViewController {

    @IBOutlet weak var questionOrAnswerLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    var cards: [Card] = []
    var cardList: [Card] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()


    }

    
    @IBAction func previousButtonTapped(_ sender: Any) {
    }
    @IBAction func nextButtonTapped(_ sender: Any) {
        let randomCard = cardList.randomElement()
        self.questionOrAnswerLabel.text = "Question:"
        self.textView.text = "\(String(describing: randomCard?.question))"
    }
    @IBAction func cardTapped(_ sender: Any) {
       
    }
    
    

    func updateViews() {
        for card in cardList {
        DispatchQueue.main.async {
            self.questionOrAnswerLabel.text = "Question:"
            self.textView.text = card.question
            self.cardList.append(card)
        }
        }
    }
    
    func flipCard() {
        if questionOrAnswerLabel.text == "Question:" {
            questionOrAnswerLabel.text = "Answer:"
        }
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
