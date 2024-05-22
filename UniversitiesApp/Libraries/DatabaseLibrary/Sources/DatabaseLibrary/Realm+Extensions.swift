//
//  Realm+Extensions.swift
//
//
//  Created by Omar Hegazy on 22/05/2024.
//

import Foundation
import RealmSwift

/// Extension for `List` to provide a convenience initializer
public extension List {
    /// Convenience initializer to create a `List` from an array of elements
    /// - Parameter array: An array of elements to initialize the `List` with
    convenience init(array: [Element]) {
        self.init()
        self.append(objectsIn: array)
    }
    
    /// Convenience initializer to create a `List` from an optional array of elements
    /// - Parameter array: An optional array of elements to initialize the `List` with
    convenience init(optionalArray: [Element]?) {
        self.init()
        if let array = optionalArray {
            self.append(objectsIn: array)
        }
    }
}

