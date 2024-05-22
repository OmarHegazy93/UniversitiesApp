//
//  UniversityDetailsInteractor.swift
//  UniversitiesApp
//
//  Created by Omar Hegazy on 22/05/2024.
//

import Foundation

// MARK: - Interactor

/// Protocol defining the interactor interface for the University Details feature
protocol UniversityDetailsInteractorProtocol: AnyObject {
    /// The presenter associated with the interactor
    var presenter: UniversityDetailsPresenterInteractorProtocol? { get set }
    
    /// Fetches the university details
    func fetchUniversityDetails()
}

/// Implementation of `UniversityDetailsInteractorProtocol`
final class UniversityDetailsInteractor: UniversityDetailsInteractorProtocol {
    /// Weak reference to the presenter to avoid retain cycles
    weak var presenter: UniversityDetailsPresenterInteractorProtocol?
    
    /// The university model containing the details to be fetched
    private let university: UniversityAPIModel
    
    /// Initializes the interactor with the specified university model
    /// - Parameter university: The university model to use
    init(university: UniversityAPIModel) {
        self.university = university
    }
    
    /// Fetches the university details
    func fetchUniversityDetails() {
        presenter?.showUniversityDetails(university)
    }
}

