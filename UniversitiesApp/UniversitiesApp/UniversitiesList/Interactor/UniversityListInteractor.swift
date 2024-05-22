
//
//  UniversityListInteractor.swift
//  UniversitiesApp
//
//  Created by Omar Hegazy on 22/05/2024.
//

import Foundation

// MARK: - Interactor

/// Protocol defining the interactor interface for the University List feature
protocol UniversityListInteractorProtocol: AnyObject {
    /// The presenter associated with the interactor
    var presenter: UniversityListPresenterInteractorProtocol? { get set }
    
    /// Fetches the list of universities
    func fetchUniversities()
    
    /// Called to refresh the data
    func refreshData()
}

/// Implementation of `UniversityListInteractorProtocol`
final class UniversityListInteractor: UniversityListInteractorProtocol {
    /// Weak reference to the presenter to avoid retain cycles
    weak var presenter: UniversityListPresenterInteractorProtocol?
    
    /// The repository used to fetch universities
    private let repository: UniversityRepositoryProtocol
    
    /// Initializes the interactor with the specified repository
    /// - Parameter repository: The repository to use
    init(repository: UniversityRepositoryProtocol) {
        self.repository = repository
    }
    
    /// Fetches the list of universities
    func fetchUniversities() {
        repository.fetchUniversities { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let universities):
                self.presenter?.universitiesFetchedSuccessfully(universities: universities)
            case .failure(let error):
                self.presenter?.universitiesFetchingFailed(with: error.localizedDescription)
            }
        }
    }
    
    /// Called to refresh the data
    func refreshData() {
        self.repository.refreshData { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let universities):
                self.presenter?.universitiesFetchedSuccessfully(universities: universities)
            case .failure(let error):
                self.presenter?.universitiesFetchingFailed(with: error.localizedDescription)
            }
        }
    }
}
