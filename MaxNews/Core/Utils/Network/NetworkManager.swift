//
//  NetworkManager.swift
//  MaxNews
//
//  Created by Didik on 12/11/20.
//

import Foundation
import Alamofire
import Combine

protocol NetworkService {
  func load<T: Decodable>(endpoint: EndPoint, parameters: Parameters?) -> AnyPublisher<T, Error>
}

class NetworkManager: NetworkService {
  static let shared = NetworkManager()
  
  func load<T: Decodable>(endpoint: EndPoint, parameters: Parameters?) -> AnyPublisher<T, Error> {
    return Future<T, Error> { completion in
      guard let url = URL(string: endpoint.url) else {
        completion(.failure(NetworkError.invalidEndpoint))
        return
      }
      
      var queryParamaters: Parameters = [:]
      queryParamaters["apiKey"] = API.apiKey
      queryParamaters["country"] = "id"

      parameters?.forEach { key, value in
        queryParamaters[key] = value
      }
      
      AF.request(url, method: .get, parameters: queryParamaters)
        .validate()
        .responseDecodable(of: T.self) { response in
          guard let statusCode = response.response?.statusCode, 200..<300 ~= statusCode else {
            completion(.failure(NetworkError.invalidResponse))
            return
          }
          
          switch response.result {
          case .success(let result):
            completion(.success(result))
          case .failure(let error):
            completion(.failure(error))
          }
        }
    }.eraseToAnyPublisher()
  }
}
