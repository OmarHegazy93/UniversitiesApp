//
//  APIManager.swift
//
//
//  Created by Omar Hegazy on 21/05/2024.
//

import Foundation

/// Protocol defining the API Manager
protocol APIManagerProtocol {
    /// Performs a network request
    /// - Parameters:
    ///   - request: The request to be performed, conforming to `RequestProtocol`
    ///   - completion: Completion handler with the result containing either data or a network error
    func perform(_ request: RequestProtocol, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

/// Implementation of the API Manager conforming to `APIManagerProtocol`
final class APIManager: APIManagerProtocol {
    /// URLSession instance used for making network requests
    private let urlSession: URLSession
    private let networkMonitor = NetworkMonitor.shared
    
    /// Initializer with dependency injection for URLSession
    /// - Parameter urlSession: The URLSession instance to use, defaults to `URLSession.shared`
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    /// Performs a network request
    /// - Parameters:
    ///   - request: The request to be performed, conforming to `RequestProtocol`
    ///   - completion: Completion handler with the result containing either data or a network error
    func perform(_ request: RequestProtocol, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard networkMonitor.isConnected else {
            completion(.failure(.noInternetConnection))
            return
        }
        
        // Attempt to create a URL request from the provided request protocol
        guard let url = try? request.createURLRequest() else {
            completion(.failure(.invalidURL))
            return
        }
        
        // Create a data task to fetch data from the network
        let task = urlSession.dataTask(with: url) { data, response, error in
            // Handle error in the network request
            if let error {
                print("❌ NetworkLibrary: error while fetching data: \(error)")
                completion(.failure(.invalidServerResponse))
                return
            }
            
            // Validate the HTTP response status code
            guard let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                print("❌ NetworkLibrary: unexpected status code: \(statusCode)")
                completion(.failure(.unexpectedStatusCode(statusCode)))
                return
            }
            
            // Ensure data is not nil
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
        }
        
        // Start the data task
        task.resume()
    }
}

