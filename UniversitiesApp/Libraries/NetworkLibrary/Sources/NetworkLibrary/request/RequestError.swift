//
//  RequestError.swift
//  
//
//  Created by Omar Hegazy on 21/05/2024.
//

import Foundation

public enum RequestError: LocalizedError {
    case networkError(NetworkError)
    case parsingError(ParsingError)
    
    /// A localized message describing what error occurred.
    public var errorDescription: String? {
        switch self {
        case .networkError(let networkError):
            return networkError.errorDescription
        case .parsingError(let parsingError):
            return parsingError.localizedDescription
        }
    }
}
