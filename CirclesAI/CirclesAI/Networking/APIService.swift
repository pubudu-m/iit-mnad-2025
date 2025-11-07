//
//  APIService.swift
//  CirclesAI
//
//  Created by Pubudu Mihiranga on 2025-11-06.
//

import Foundation

enum HTTPMethod: String {
    case GET, POST
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed(Error)
    case decodingFailed(Error)
    case unknown
}


