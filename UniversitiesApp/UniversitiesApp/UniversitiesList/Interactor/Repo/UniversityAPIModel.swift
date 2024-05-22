//
//  UniversityAPIModel.swift
//  UniversitiesApp
//
//  Created by Omar Hegazy on 22/05/2024.
//

import Foundation
import DatabaseLibrary
import RealmSwift

// MARK: - UniversityAPIModel

/// Model representing a university, conforming to Codable, Identifiable, and Persistable protocols
struct UniversityAPIModel: Codable, Identifiable, Persistable {
    /// Unique identifier for the university
    var id: String = UUID().uuidString
    /// The alpha two code of the university's country
    let alphaTwoCode: String?
    /// The country where the university is located
    let country: String
    /// The domains associated with the university
    let domains: [String]
    /// The name of the university
    let name: String
    /// The state or province where the university is located, if applicable
    let stateProvince: String?
    /// The web pages associated with the university
    let webPages: [String]?
    
    /// Coding keys to map the JSON keys to the model's properties
    enum CodingKeys: String, CodingKey {
        case alphaTwoCode = "alpha_two_code"
        case country, domains, name
        case stateProvince = "state-province"
        case webPages = "web_pages"
    }
    
    /// Converts the model to a Realm persistence object
    /// - Returns: An instance of `UniversityPersistenceModel`
    func toRealmObject() -> UniversityPersistenceModel {
        let university = UniversityPersistenceModel()
        university.id = id
        university.alphaTwoCode = alphaTwoCode
        university.country = country
        university.domains = List<String>(array: domains)
        university.name = name
        university.stateProvince = stateProvince
        university.webPages = List<String>(optionalArray: webPages)
        return university
    }
}

/// Extension for initializing `UniversityAPIModel` from a Realm persistence object
extension UniversityAPIModel {
    /// Initializes the model from a Realm persistence object
    /// - Parameter realmObject: The Realm persistence object
    init(realmObject: UniversityPersistenceModel) {
        self.id = realmObject.id
        self.alphaTwoCode = realmObject.alphaTwoCode
        self.country = realmObject.country
        self.domains = realmObject.domains.map { $0 }
        self.name = realmObject.name
        self.stateProvince = realmObject.stateProvince
        self.webPages = realmObject.webPages?.map { $0 }
    }
}
