//
//  Card.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/2/21.
//

import UIKit
import CloudKit

///This is the model for a single flash card

struct CardStrings {
    static let recordTypeKey = "Card"
    static let questionTypeKey = "question"
    static let answerTypeKey = "answer"
    static let deckTypeKey = "deck"
}

class Card {
    
    let question: String
    let answer: String
    let deck: String
    var recordID: CKRecord.ID
    
    init(question: String, answer: String, deck: String, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.question = question
        self.answer = answer
        self.deck = deck
        self.recordID = recordID
        }
}

extension Card {
   convenience init?(ckRecord: CKRecord) {
        guard let question = ckRecord[CardStrings.questionTypeKey] as? String,
              let answer = ckRecord[CardStrings.answerTypeKey] as? String,
              let deck = ckRecord[CardStrings.deckTypeKey] as? String
        else {return nil}
        
        self.init(question: question, answer: answer, deck: deck, recordID: ckRecord.recordID)
    }
}


extension CKRecord {
    
    convenience init(card: Card) {
        self.init(recordType: CardStrings.recordTypeKey, recordID: card.recordID)
        self.setValuesForKeys([
            CardStrings.questionTypeKey : card.question,
            CardStrings.answerTypeKey : card.answer,
            CardStrings.deckTypeKey : card.deck
        
        ])
    }
}

extension Card: Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.recordID == rhs.recordID
    }
}
