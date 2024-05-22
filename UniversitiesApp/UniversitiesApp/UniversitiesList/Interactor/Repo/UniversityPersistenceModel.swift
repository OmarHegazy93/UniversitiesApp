//
//  UniversityPersistenceModel.swift
//  UniversitiesApp
//
//  Created by Omar Hegazy on 22/05/2024.
//

import Foundation
import RealmSwift

/// Realm object model representing a university for persistence
final class UniversityPersistenceModel: Object {
    /// Unique identifier for the university
    @objc dynamic var id: String = UUID().uuidString
    /// The name of the university
    @objc dynamic var name: String = ""
    /// The country where the university is located
    @objc dynamic var country: String = ""
    /// The domains associated with the university
    var domains = List<String>()
    /// The state or province where the university is located, if applicable
    @objc dynamic var stateProvince: String?
    /// The alpha two code of the university's country
    @objc dynamic var alphaTwoCode: String?
    /// The web pages associated with the university
    var webPages: List<String>?
    
    /// Defines the primary key for the Realm object
    /// - Returns: The name of the primary key property, "id"
    override static func primaryKey() -> String? {
        return "id"
    }
}
