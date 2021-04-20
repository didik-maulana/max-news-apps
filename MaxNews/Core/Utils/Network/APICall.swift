//
//  APICall.swift
//  MaxNews
//
//  Created by Didik on 12/11/20.
//

struct API {
  static let apiKey = "3964c57788ee4edcad4038d6bc318c18"
  static let baseUrl = "https://newsapi.org/v2"
}

enum EndPoint {
  case topHeadlines
  case sources
  
  var url: String {
    switch self {
    case .topHeadlines:
      return "\(API.baseUrl)/top-headlines"
    case .sources:
      return "\(API.baseUrl)/sources"
    }
  }
}
