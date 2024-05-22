//
//  RequestManager.swift
//  
//
//  Created by Omar Hegazy on 21/05/2024.
//


/// Protocol defining the Request Manager
public protocol RequestManagerProtocol {
    /// Performs a network request and parses the response
    /// - Parameters:
    ///   - request: The request to be performed, conforming to `RequestProtocol`
    ///   - completion: Completion handler with the result containing either a decoded object or a request error
    func perform<T: Decodable>(
        _ request: RequestProtocol,
        completion: @escaping (Result<T, RequestError>) -> Void
    )
}

/// Implementation of the Request Manager conforming to `RequestManagerProtocol`
final public class RequestManager: RequestManagerProtocol {
    /// The API manager used to perform network requests
    private let apiManager: APIManagerProtocol
    /// The data parser used to parse the response data
    private let parser: DataParserProtocol
    
    public static let shared = RequestManager()
    
    /// Initializer with dependency injection for APIManager and DataParser
    /// - Parameters:
    ///   - apiManager: The API manager to use, defaults to `APIManager`
    ///   - parser: The data parser to use, defaults to `DataParser`
    init(
        apiManager: APIManagerProtocol = APIManager(),
        parser: DataParserProtocol = DataParser()
    ) {
        self.apiManager = apiManager
        self.parser = parser
    }
    
    /// Performs a network request and parses the response
    /// - Parameters:
    ///   - request: The request to be performed, conforming to `RequestProtocol`
    ///   - completion: Completion handler with the result containing either a decoded object or a request error
    public func perform<T: Decodable>(
        _ request: RequestProtocol,
        completion: @escaping (Result<T, RequestError>) -> Void
    ) {
        // Perform the network request using the API manager
        apiManager.perform(request) { [weak self] result in
            // Ensure self is not nil
            guard let self else { return }
            
            // Handle the result of the network request
            switch result {
            case .success(let data):
                // Parse the received data
                let parseResult: Result<T, ParsingError> = self.parser.parse(data)
                switch parseResult {
                case .success(let model):
                    // Return the parsed model on success
                    completion(.success(model))
                case .failure(let error):
                    // Return a parsing error on failure
                    completion(.failure(.parsingError(error)))
                }
            case .failure(let error):
                // Return a network error on failure
                completion(.failure(.networkError(error)))
            }
        }
    }
}
