//
//  ArticleResponse.swift
//  MaxNews
//
//  Created by Didik on 11/11/20.
//

import Foundation

struct ArticlesResponse: Decodable {
  let articles: [ArticleResponse]
}

extension ArticlesResponse {
  func mapToDomain() -> [ArticleModel] {
    return articles.map { article in
      return ArticleModel(
        source: article.source.mapToDomain(),
        author: article.author ?? "Unknown",
        title: article.title ?? "Unknown",
        description: article.description ?? "Unknown",
        url: article.url ?? "Unknown",
        urlToImage: article.urlToImage ?? "Unknown",
        publishedAt: article.publishedAt ?? "Unknown",
        content: article.content ?? "Unknown"
      )
    }
  }
}
