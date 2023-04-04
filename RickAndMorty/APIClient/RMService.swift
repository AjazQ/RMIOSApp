//
//  RMService.swift
//  RickAndMorty
//
//  Created by PS19Developer on 31/03/2023.
//

import Foundation
///Primary API Service object to get Rick and Morty data
final class RMService{
    enum RMServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    /// Shared singleton instance
    static let shared = RMService()
    
    /// Privatized constructor
    private init(){}
    
    /// Send Rick and Morty API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - completion: Callback with data or error
    public func execute <T: Codable >(
        _ request: RMRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void ){
            guard let urlRequest = self.request(from: request) else {
                completion(.failure(RMServiceError.failedToCreateRequest))
                return
            }
            //task to get url data
            let task = URLSession.shared.dataTask(with: urlRequest){ data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(RMServiceError.failedToGetData))
                    return
                }
                //Decode response
                do{
                    let result = try JSONDecoder().decode(type.self, from: data)
                    //print(String(String(describing: json)))
                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }
            }
            task.resume()
            
    }
        //MARK: - Private
    private func request(from rmRequest:RMRequest) -> URLRequest?{
        guard let url = rmRequest.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        return request
        
    }
}
