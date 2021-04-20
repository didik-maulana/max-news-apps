//
//  SourceResponse.swift
//  MaxNews
//
//  Created by Didik on 12/11/20.
//

import Foundation

struct SourceResponse: Decodable {
  let name: String?
}

extension SourceResponse {
  func mapToDomain() -> SourceModel {
    return SourceModel(name: name ?? "Unknown")
  }
}
