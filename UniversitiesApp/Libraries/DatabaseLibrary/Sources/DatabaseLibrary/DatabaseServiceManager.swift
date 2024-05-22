//
//  DatabaseServiceManager.swift
//
//
//  Created by Omar Hegazy on 22/05/2024.
//

import Foundation
import RealmSwift

/// Implementation of `DatabaseServiceManager` using Realm
final public class DatabaseServiceManager<T: Persistable>: DatabaseService {
    /// The manager handling Realm database operations
    private let manager = RealmManager()
    
    public init() { }
    
    /// Saves a new model in the Realm database
    /// - Parameter model: The model to be saved
    /// - Throws: An error if the creation fails
    public func save(_ model: T) throws {
        try manager.create(model)
    }
    
    /// Reads a model from the Realm database using a key
    /// - Parameter key: The key to identify the model
    /// - Returns: The model if found, otherwise nil
    /// - Throws: An error if the read operation fails
    public func read(key: Any) throws -> T? {
        return try manager.read(type: T.RealmType.self, key: key)
    }
    
    /// Updates an existing model in the Realm database
    /// - Parameter model: The model to be updated
    /// - Throws: An error if the update fails
    public func update(_ model: T) throws {
        try manager.update(model)
    }
    
    /// Deletes a model from the Realm database
    /// - Parameter model: The model to be deleted
    /// - Throws: An error if the deletion fails
    public func delete(_ model: T) throws {
        try manager.delete(model)
    }
    
    /// Deletes all models from the Realm database
    /// - Throws: An error if the deletion fails
    public func deleteAll() throws {
        try manager.deleteAll()
    }
    
    /// Fetches all models from the Realm database
    /// - Returns: An array of all models
    /// - Throws: An error if the fetch operation fails
    public func fetchAll() throws -> [T] {
        return try manager.fetchAll(type: T.RealmType.self)
    }
}
