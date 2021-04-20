//
//  HomePresenter.swift
//  MaxNews
//
//  Created by Didik on 12/11/20.
//

import Foundation
import Combine

class NewsPresenter {
  @Published var categories: [CategoryModel] = []
  @Published var articles: [ArticleModel] = []
  @Published var message: String? = nil
  @Published var isLoading: Bool = false
  
  private var cancelables: Set<AnyCancellable> = []
  private let newsUseCase: NewsUseCase
  
  init(homeUseCase: NewsUseCase) {
    self.newsUseCase = homeUseCase
  }
  
  func getCategories() {
    newsUseCase.getCategories()
      .receive(on: RunLoop.main)
      .sink(
        receiveCompletion: { completion in
          
        }, receiveValue: { categories in
          self.categories = categories
        }
      ).store(in: &cancelables)
  }
  
  func getArticles(category: String?) {
    isLoading = true
    newsUseCase.getArticles(category: category ?? Category.all.rawValue)
      .receive(on: RunLoop.main)
      .sink(
        receiveCompletion: { [weak self] completion in
          guard let self = self else { return }
          switch completion {
          case .finished:
            self.isLoading = false
          case .failure(let error):
            self.message = error.localizedDescription
          }
        },
        receiveValue: { articles in
          self.articles = articles
        }
      ).store(in: &cancelables)
  }
}
