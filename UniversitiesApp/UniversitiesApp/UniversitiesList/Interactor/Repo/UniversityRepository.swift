//
//  UniversityRepository.swift
//  UniversitiesApp
//
//  Created by Omar Hegazy on 22/05/2024.
//

import Foundation
import NetworkLibrary
import DatabaseLibrary

// MARK: - Repository

/// Protocol defining the repository interface for fetching universities
protocol UniversityRepositoryProtocol: AnyObject {
    /// Fetches the list of universities
    /// - Parameter completion: A closure that returns a result containing an array of `UniversityAPIModel` or an error
    func fetchUniversities(completion: @escaping (Result<[UniversityAPIModel], Error>) -> Void)
    
    /// Delete all universities and fetch them again
    func refreshData(completion: @escaping (Result<[UniversityAPIModel], Error>) -> Void)
}

/// Implementation of `UniversityRepositoryProtocol`
final class UniversityRepository: UniversityRepositoryProtocol {
    /// The network manager used to perform network requests
    private let networkManager: RequestManagerProtocol
    /// The persistence service used to manage database operations
    private let persistenceService: DatabaseServiceManager<UniversityAPIModel>
    
    /// Initializes the repository with the specified network manager and persistence service
    /// - Parameters:
    ///   - networkManager: The network manager to use, defaults to `RequestManager.shared`
    ///   - persistenceService: The persistence service to use, defaults to a new instance of `DatabaseServiceManager<UniversityAPIModel>`
    init(
        networkManager: RequestManagerProtocol = RequestManager.shared,
        persistenceService: DatabaseServiceManager<UniversityAPIModel> = DatabaseServiceManager<UniversityAPIModel>()
    ) {
        self.networkManager = networkManager
        self.persistenceService = persistenceService
    }
    
    /// Fetches the list of universities
    /// - Parameter completion: A closure that returns a result containing an array of `UniversityAPIModel` or an error
    func fetchUniversities(completion: @escaping (Result<[UniversityAPIModel], Error>) -> Void) {
        networkManager.perform(UniversitiesRequest.getUniversities("United Arab Emirates")) { [weak self] (result: Result<[UniversityAPIModel], RequestError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let universities):
                do {
                    try self.persistenceService.deleteAll()
                    for university in universities {
                        try self.persistenceService.save(university)
                    }
                    completion(.success(universities))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                do {
                    let universities = try self.persistenceService.fetchAll()
                    if universities.isEmpty {
                        completion(.failure(error))
                    } else {
                        completion(.success(universities))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func refreshData(completion: @escaping (Result<[UniversityAPIModel], Error>) -> Void) {
        do {
            try persistenceService.deleteAll()
            fetchUniversities(completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}
