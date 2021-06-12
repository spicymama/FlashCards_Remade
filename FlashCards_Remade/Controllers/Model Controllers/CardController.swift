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
    
    var deckNames: [String] = [].sorted { $0.lowercased() < $1.lowercased() }
    
    var deckIndex: IndexPath = [0]
    
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
        if !self.deckNames.contains(deck) {
            self.deckNames.append(deck)
            self.deckNames = self.deckNames.sorted { $0.lowercased() < $1.lowercased() }
            }
        }
    }
    var cardsToDelete: [Card] = []
    
    func deleteDeck(card: Card, completion: @escaping (Result<Bool, CardError>)-> Void) {
        let deck = card.deck
        for card in CardController.shared.cards {
            if card.deck == deck {
                cardsToDelete.append(card)
            }
        }
        for card in cardsToDelete {
            let index = cardsToDelete.firstIndex(of: card)
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
                
                guard let  deckToDelete = CardController.shared.deckNames.sorted(by: { $0.lowercased() < $1.lowercased() }).firstIndex(of: deck) else {return}
                if self.deckNames.contains(deck) && self.cardsToDelete.count == 0 {
                    self.deckIndex = [deckToDelete]
                self.deckNames.remove(at: deckToDelete)
                    self.deckNames = self.deckNames.sorted { $0.lowercased() < $1.lowercased() }

                }
            } else {
                return completion(.failure(.unexpectedRecordsFound))
            }
        }
        
        privateDB.add(deleteOperation)
        }
        cardsToDelete = []
    }
    
    
    
    
    
    func deleteCard(card: Card, completion: @escaping (Result<Bool, CardError>)-> Void) {
        guard let index = CardController.shared.cards.firstIndex(of: card) else {return}
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
                CardController.shared.cards.remove(at: index)
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
            
            print("we got \(self.cards.count) cards")
           for card in self.cards {
                if !self.deckNames.contains(card.deck) {
                    self.deckNames.append(card.deck)
                    self.deckNames = self.deckNames.sorted { $0.lowercased() < $1.lowercased() }
                }
            }
 
            completion(.success(self.cards))
        }
        print(deckNames)
    }
}//End of class
