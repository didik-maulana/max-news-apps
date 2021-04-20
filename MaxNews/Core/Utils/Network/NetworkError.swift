//
//  NetworkError.swift
//  MaxNews
//
//  Created by Didik on 12/11/20.
//

enum NetworkError: Error {
    case invalidEndpoint
    case invalidResponse
    
    var localizedDescription: String {
        switch self {
        case .invalidEndpoint:
            return "Invalid endpoint"
        case .invalidResponse:
            return "Invalid response status code"
        }
    }
}
