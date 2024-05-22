//
//  File.swift
//  
//
//  Created by Omar Hegazy on 22/05/2024.
//

import Foundation

public enum DatabaseError: Error {
    case realmInitializationFailed
    case objectNotFound
    case writeFailed(error: Error)
    case readFailed(error: Error)
    case updateFailed(error: Error)
    case deleteFailed(error: Error)
    case unknownError(error: Error)
    
    var localizedDescription: String {
        switch self {
        case .realmInitializationFailed:
            return "Failed to initialize Realm database."
        case .objectNotFound:
            return "Object not found in the database."
        case .writeFailed(let error):
            return "Failed to write to the database: \(error.localizedDescription)"
        case .readFailed(let error):
            return "Failed to read from the database: \(error.localizedDescription)"
        case .updateFailed(let error):
            return "Failed to update the database: \(error.localizedDescription)"
        case .deleteFailed(let error):
            return "Failed to delete from the database: \(error.localizedDescription)"
        case .unknownError(let error):
            return "An unknown error occurred: \(error.localizedDescription)"
        }
    }
}
