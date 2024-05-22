//
//  UniversityRequest.swift
//  UniversitiesApp
//
//  Created by Omar Hegazy on 22/05/2024.
//

import Foundation
import NetworkLibrary

/// Enum representing different university-related requests
enum UniversitiesRequest: RequestProtocol {
    /// Request to get universities for a specific country
    case getUniversities(String)
    
    /// The path for the request
    var path: String {
        "/search"
    }
    
    /// The URL parameters for the request
    var urlParams: [String: String?] {
        switch self {
        case .getUniversities(let country):
            return ["country": country]
        }
    }
    
    /// The HTTP method for the request
    var requestType: RequestType {
        .GET
    }
}
