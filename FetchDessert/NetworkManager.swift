//
//  NetworkManager.swift
//  FetchDessert
//
//  Created by A.d. Ahmed on 9/30/24.
//

import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    // For async/await version
    func fetch<T: Decodable>(url: URL?, decodingType: T.Type) async throws -> T {
        guard let url = url else {
            throw NetworkError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    // For Combine version
    func fetchPublisher<T: Decodable>(url: URL?, decodingType: T.Type) -> AnyPublisher<T, Error> {
        guard let url = url else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    enum NetworkError: Error {
        case invalidURL
        case noData
        case decodingFailed
    }
}
