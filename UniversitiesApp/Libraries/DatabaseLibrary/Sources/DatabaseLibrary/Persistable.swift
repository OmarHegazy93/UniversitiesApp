//
//  File 2.swift
//  
//
//  Created by Omar Hegazy on 22/05/2024.
//

import Foundation
import RealmSwift

/// Protocol defining a persistable model for database operations
public protocol Persistable {
    /// The type of Realm object that corresponds to the persistable model
    associatedtype RealmType: Object
    
    /// Converts the model to a Realm object
    /// - Returns: A Realm object representing the model
    func toRealmObject() -> RealmType
    
    /// Initializes the model from a Realm object
    /// - Parameter realmObject: The Realm object used to initialize the model
    init(realmObject: RealmType)
}

