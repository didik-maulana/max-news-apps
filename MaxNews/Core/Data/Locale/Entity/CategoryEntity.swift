//
//  CategoryEntity.swift
//  MaxNews
//
//  Created by Didik on 13/11/20.
//

enum Category: String {
  case technology
  case science
  case sports
  case health
  case business
  case entertainment
  case general
  case all
  
  var text: String {
    switch self {
    case .technology:
      return "Technology"
    case .science:
      return "Science"
    case .sports:
      return "Sports"
    case .health:
      return "Health"
    case .business:
      return "Business"
    case .entertainment:
      return "Entertainment"
    case .general:
      return "General"
    case .all:
      return "All"
    }
  }
}

struct CategoryEntity {
  let category: Category
  let isSelected: Bool
  
  init(category: Category, isSelected: Bool = false) {
    self.category = category
    self.isSelected = isSelected
  }
}

extension CategoryEntity {
  func mapToDomain() -> CategoryModel {
    return CategoryModel(
      key: category.rawValue,
      category: category.text,
      isSelected: isSelected
    )
  }
}
