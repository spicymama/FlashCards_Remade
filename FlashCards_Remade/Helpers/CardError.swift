//
//  CardError.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/2/21.
//

import Foundation


enum CardError: LocalizedError {
    case ckError(Error)
    case couldNotUnwrap
    case unexpectedRecordsFound
    
    var errorDescription: String? {
        switch self {
        case .ckError(let error):
            return "There was an error -- \(error) -- \(error.localizedDescription)."
        case .couldNotUnwrap:
            return "There was an error unwrapping the Card."
        case .unexpectedRecordsFound:
            return "There were unexpected records found on CloudKit"
        }
    }
}
