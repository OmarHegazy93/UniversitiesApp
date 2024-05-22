//
//  File.swift
//  
//
//  Created by Omar Hegazy on 22/05/2024.
//

import Foundation

/// Enum representing possible parsing errors
public enum ParsingError: Error {
    /// Error indicating invalid data with the associated underlying error
    case invalidData(Error)
}
