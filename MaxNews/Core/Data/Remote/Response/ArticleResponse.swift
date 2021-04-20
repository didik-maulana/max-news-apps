//
//  ArticleResponse.swift
//  MaxNews
//
//  Created by Didik on 12/11/20.
//

import Foundation

struct ArticleResponse: Decodable {
  let source: SourceResponse
  let author: String?
  let title: String?
  let description: String?
  let url: String?
  let urlToImage: String?
  let publishedAt: String?
  let content: String?
}
