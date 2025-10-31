//
//  DefaultNetworkingService.swift
//  GhibliApp
//
//  Created by Pubudu Mihiranga on 2025-10-31.
//

import Foundation

struct DefaultNetworkingService {
    func fetch<T: Decodable>(urlString: String, type: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            
           return try JSONDecoder().decode(type, from: data)
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
    }
}
