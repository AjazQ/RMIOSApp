//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by PS19Developer on 31/03/2023.
//

import Foundation

/// Object that represents a single API call
final class RMRequest {
    private struct Constants {
        static let baseURL = "https://rickandmortyapi.com/api"
    }
    
    /// Desired endpoint
    private let endPoint: RMEndpoint
    /// Path compoent for API, if any
    private let pathComponent: [String]
    /// Query arguments for API, if any
    private let queryParameters: [URLQueryItem]
    
    ///Computed Property to get url
    ///
    private var urlString: String {
        var string = Constants.baseURL
        string += "/"
        string += endPoint.rawValue
        
        if !pathComponent.isEmpty {
            pathComponent.forEach({string += "/\($0)"})
        }
        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        return string

    }
    /// Computed & constructed API url
    public var url: URL? {
        return URL(string : urlString)
    }
    /// Desired http method
    public let httpMethod = "GET"
    // MARK: - Public
    
    /// Construct request
    /// - Parameters:
    ///   - endPoint: Target endpoint
    ///   - pathComponent: Collection of Path components
    ///   - queryParameters: Collection of query parameters
    public init(
        endPoint: RMEndpoint,
        pathComponent: [String] = [],
        queryParameters: [URLQueryItem] = []
    ){
        self.endPoint = endPoint
        self.pathComponent = pathComponent
        self.queryParameters = queryParameters
    }
}
extension RMRequest{
    static let listCharactersRequests = RMRequest(endPoint: .character)
}
