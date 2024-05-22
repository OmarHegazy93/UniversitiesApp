//
//  DatabaseService.swift
//  
//
//  Created by Omar Hegazy on 22/05/2024.
//

import Foundation
import RealmSwift

/// Protocol defining the database service interface
public protocol DatabaseService {
    /// The type of model that conforms to `Persistable` to be used in the database service
    associatedtype ModelType: Persistable
    
    /// Saves a new model in the database
    /// - Parameter model: The model to be saved
    /// - Throws: An error if the creation fails
    func save(_ model: ModelType) throws
    
    /// Reads a model from the database using a key
    /// - Parameter key: The key to identify the model
    /// - Returns: The model if found, otherwise nil
    /// - Throws: An error if the read operation fails
    func read(key: Any) throws -> ModelType?
    
    /// Updates an existing model in the database
    /// - Parameter model: The model to be updated
    /// - Throws: An error if the update fails
    func update(_ model: ModelType) throws
    
    /// Deletes a model from the database
    /// - Parameter model: The model to be deleted
    /// - Throws: An error if the deletion fails
    func delete(_ model: ModelType) throws
    
    /// Deletes all models from the database
    /// - Throws: An error if the deletion fails
    func deleteAll() throws
    
    /// Fetches all models from the database
    /// - Returns: An array of all models
    /// - Throws: An error if the fetch operation fails
    func fetchAll() throws -> [ModelType]
}

