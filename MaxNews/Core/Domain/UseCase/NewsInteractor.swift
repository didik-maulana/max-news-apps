//
//  HomeInteractor.swift
//  MaxNews
//
//  Created by Didik on 12/11/20.
//

import Foundation
import Combine

protocol NewsUseCase {
  func getCategories() -> AnyPublisher<[CategoryModel], Error>
  func getArticles(category: String) -> AnyPublisher<[ArticleModel], Error>
}

final class NewsInteractor: NewsUseCase {
  private let repository: NewsRepository
  
  required init(repository: NewsRepository) {
    self.repository = repository
  }
  
  func getCategories() -> AnyPublisher<[CategoryModel], Error> {
    return repository.getCategories()
  }
  
  func getArticles(category: String) -> AnyPublisher<[ArticleModel], Error> {
    return repository.getArticles(category: category)
  }
}
