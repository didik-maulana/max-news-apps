//
//  RemoteDataSource.swift
//  MaxNews
//
//  Created by Didik on 11/11/20.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSource: class {
  func getArticles(category: String) -> AnyPublisher<ArticlesResponse, Error>
}

final class RemoteDataSourceImpl: NSObject {
  private override init() {}
  
  static let shared: RemoteDataSourceImpl = RemoteDataSourceImpl()
  private let networkManager = NetworkManager.shared
}

extension RemoteDataSourceImpl: RemoteDataSource {
  func getArticles(category: String) -> AnyPublisher<ArticlesResponse, Error> {
    var parameters: Parameters = [:]
    parameters["category"] = category
    return networkManager.load(endpoint: .topHeadlines, parameters: parameters)
  }
}
