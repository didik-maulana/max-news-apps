//
//  NewsRepository.swift
//  MaxNews
//
//  Created by Didik on 12/11/20.
//

import Foundation
import Combine

protocol NewsRepository {
  func getCategories() -> AnyPublisher<[CategoryModel], Error>
  func getArticles(category: String) -> AnyPublisher<[ArticleModel], Error>
}

final class NewsRepositoryImpl: NSObject {
  typealias NewsRepositoryInstance = (RemoteDataSource, LocaleDataSource) -> NewsRepositoryImpl
  
  private let remote: RemoteDataSource
  private let locale: LocaleDataSource
  
  init(remote: RemoteDataSource, locale: LocaleDataSource) {
    self.remote = remote
    self.locale = locale
  }
  
  static let shared: NewsRepositoryInstance = { remote, locale in
    return NewsRepositoryImpl(remote: remote, locale: locale)
  }
}

extension NewsRepositoryImpl: NewsRepository {
  func getCategories() -> AnyPublisher<[CategoryModel], Error> {
    return self.locale.getCategories()
      .flatMap { result -> AnyPublisher<[CategoryModel], Error> in
        return self.locale.getCategories()
          .map { categories in
            var temp: [CategoryModel] = []
            categories.forEach { category in
              temp.append(category.mapToDomain())
            }
            return temp
          }.eraseToAnyPublisher()
      }.eraseToAnyPublisher()
  }
  
  func getArticles(category: String) -> AnyPublisher<[ArticleModel], Error> {
    return self.remote.getArticles(category: category)
      .flatMap { result -> AnyPublisher<[ArticleModel], Error> in
        return self.remote.getArticles(category: category)
          .map { $0.mapToDomain() }
          .eraseToAnyPublisher()
      }.eraseToAnyPublisher()
  }
}
