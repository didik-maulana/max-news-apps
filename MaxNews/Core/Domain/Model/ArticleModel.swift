//
//  ArticleModel.swift
//  MaxNews
//
//  Created by Didik on 11/11/20.
//

import Foundation

struct ArticleModel {
  let id: UUID = UUID()
  let source: SourceModel
  let author: String
  let title: String
  let description: String
  let url: String
  let urlToImage: String
  let publishedAt: String
  let content: String
  
  var imageURL: URL? {
    return URL(string: urlToImage)
  }
  
  var publishedDate: String {
    let inputDateFormatter = DateFormatter()
    inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM dd, yyyy"
    
    if let date = inputDateFormatter.date(from: publishedAt) {
      let formattedDate = dateFormatter.string(from: date)
      return formattedDate
    } else {
      return "Unknown"
    }
  }
}
