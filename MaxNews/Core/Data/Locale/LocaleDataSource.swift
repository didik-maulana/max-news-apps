//
//  LocaleDataSource.swift
//  MaxNews
//
//  Created by Didik on 13/11/20.
//

import Foundation
import Combine

protocol LocaleDataSource {
  func getCategories() -> AnyPublisher<[CategoryEntity], Error>
}

final class LocaleDataSourceImpl: NSObject {
  private override init() {}
  
  static let shared = LocaleDataSourceImpl()
}

extension LocaleDataSourceImpl: LocaleDataSource {
  func getCategories() -> AnyPublisher<[CategoryEntity], Error> {
    return Future<[CategoryEntity], Error> { completion in
      var categories: [CategoryEntity] = []
      categories.append(CategoryEntity(category: .technology, isSelected: true))
      categories.append(CategoryEntity(category: .science))
      categories.append(CategoryEntity(category: .sports))
      categories.append(CategoryEntity(category: .health))
      categories.append(CategoryEntity(category: .business))
      categories.append(CategoryEntity(category: .entertainment))
      categories.append(CategoryEntity(category: .general))
      categories.append(CategoryEntity(category: .all))
      
      completion(.success(categories))
    }.eraseToAnyPublisher()
  }
}
