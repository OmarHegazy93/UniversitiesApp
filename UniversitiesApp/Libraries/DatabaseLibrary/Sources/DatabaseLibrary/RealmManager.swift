//
//  RealmManager.swift
//  
//
//  Created by Omar Hegazy on 22/05/2024.
//

import Foundation
import RealmSwift

/// A manager class for handling Realm database operations
final public class RealmManager {
    /// The Realm configuration to be used
    private let configuration: Realm.Configuration
    
    /// Initialize with either default or in-memory configuration
    /// - Parameter inMemoryIdentifier: An optional identifier for in-memory Realm configuration
    public init(inMemoryIdentifier: String? = nil) {
        if let identifier = inMemoryIdentifier {
            self.configuration = Realm.Configuration(inMemoryIdentifier: identifier)
        } else {
            self.configuration = Realm.Configuration.defaultConfiguration
        }
    }
    
    // MARK: - CRUD Operations
    
    /// Creates a new model in the Realm database
    /// - Parameters:
    ///   - model: The model to be created
    ///   - update: A flag indicating whether to update the model if it already exists, defaults to true
    /// - Throws: `DatabaseError.writeFailed` if the creation fails
    public func create<T: Persistable>(_ model: T, update: Bool = true) throws {
        do {
            let realm = try Realm(configuration: configuration)
            try realm.write {
                realm.add(model.toRealmObject(), update: .all)
            }
        } catch {
            throw DatabaseError.writeFailed(error: error)
        }
    }
    
    /// Reads a model from the Realm database using a key
    /// - Parameters:
    ///   - type: The type of the Realm object
    ///   - key: The key to identify the model
    /// - Returns: The model if found, otherwise nil
    /// - Throws: `DatabaseError.readFailed` if the read operation fails or `DatabaseError.objectNotFound` if the object is not found
    public func read<T: Persistable, K: Object>(type: K.Type, key: Any) throws -> T? where K == T.RealmType {
        do {
            let realm = try Realm(configuration: configuration)
            if let object = realm.object(ofType: type, forPrimaryKey: key) {
                return T(realmObject: object)
            } else {
                throw DatabaseError.objectNotFound
            }
        } catch {
            throw DatabaseError.readFailed(error: error)
        }
    }
    
    /// Updates an existing model in the Realm database
    /// - Parameter model: The model to be updated
    /// - Throws: `DatabaseError.updateFailed` if the update fails
    public func update<T: Persistable>(_ model: T) throws {
        do {
            let realm = try Realm(configuration: configuration)
            try realm.write {
                realm.add(model.toRealmObject(), update: .modified)
            }
        } catch {
            throw DatabaseError.updateFailed(error: error)
        }
    }
    
    /// Deletes a model from the Realm database
    /// - Parameter model: The model to be deleted
    /// - Throws: `DatabaseError.deleteFailed` if the deletion fails or `DatabaseError.objectNotFound` if the object is not found
    public func delete<T: Persistable>(_ model: T) throws {
        do {
            let realm = try Realm(configuration: configuration)
            try realm.write {
                if let object = realm.object(ofType: T.RealmType.self, forPrimaryKey: model.toRealmObject().value(forKey: "id")) {
                    realm.delete(object)
                } else {
                    throw DatabaseError.objectNotFound
                }
            }
        } catch {
            throw DatabaseError.deleteFailed(error: error)
        }
    }
    
    /// Deletes all models from the Realm database
    /// - Throws: `DatabaseError.deleteFailed` if the deletion fails
    public func deleteAll() throws {
        do {
            let realm = try Realm(configuration: configuration)
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            throw DatabaseError.deleteFailed(error: error)
        }
    }
    
    /// Fetches all models from the Realm database
    /// - Parameter type: The type of the Realm object
    /// - Returns: An array of all models
    /// - Throws: `DatabaseError.readFailed` if the fetch operation fails
    public func fetchAll<T: Persistable, K: Object>(type: K.Type) throws -> [T] where K == T.RealmType {
        do {
            let realm = try Realm(configuration: configuration)
            let objects = realm.objects(type)
            return objects.map { T(realmObject: $0) }
        } catch {
            throw DatabaseError.readFailed(error: error)
        }
    }
}
