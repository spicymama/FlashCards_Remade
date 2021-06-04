//
//  CardController.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/2/21.
//

import UIKit
import CloudKit

class CardController {
    
    static let shared = CardController()
    
    var cards: [Card] = []
    
    var deckNames: [String] = []
    
    var defaultCard = Card(question: "Default", answer: "Default", deck: "Default")
    
    let privateDB = CKContainer.default().privateCloudDatabase
    
    
    //MARK: - CRUD Functions
    
    func createCard(question: String, answer: String, deck: String, completion: @escaping (_ _result: Result<Card?, CardError>)-> Void) {
        
        let newCard = Card(question: question, answer: answer, deck: deck)
        
        let cardRecord = CKRecord(card: newCard)
        privateDB.save(cardRecord) { (record, error) in
            
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(.failure(.ckError(error)))
                return
            }
            
            guard let record = record,
                  let savedCard = Card(ckRecord: record)
            else { completion(.failure(.couldNotUnwrap)); return }
            print("New card saved successfully")
            self.cards.insert(savedCard, at: 0)
            
            completion(.success(savedCard))
        }
    }
    
    func deleteCard(card: Card, completion: @escaping (Result<Bool, CardError>)-> Void) {
        let deleteOperation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: [card.recordID])
        deleteOperation.savePolicy = .changedKeys
        deleteOperation.qualityOfService = .userInteractive
        deleteOperation.modifyRecordsCompletionBlock = { (records, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.ckError(error)))
            }
            if records?.count == 0 {
                print("Deleted records from CloudKit")
                completion(.success(true))
            } else {
                return completion(.failure(.unexpectedRecordsFound))
            }
        }
        privateDB.add(deleteOperation)
    }
    
    
    func fetchCards(completion: @escaping (_ result: Result<[Card]?, CardError>)-> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: CardStrings.recordTypeKey, predicate: predicate)
        
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(.failure(.ckError(error)))
            }
            guard let records = records else { completion(.failure(.couldNotUnwrap)); return}
            print("Successfully fetched all cards")
            print(CardController.shared.cards.count)

            
            let fetchedCards = records.compactMap({Card(ckRecord: $0) })
            self.cards = fetchedCards
            completion(.success(self.cards))
        }
        
        for card in cards {
            if !deckNames.contains(card.deck) {
                deckNames.append(card.deck)
            }
        }
        print(deckNames)
    }
}//End of class
