//
//  CategoryNode.swift
//  MaxNews
//
//  Created by Didik on 13/11/20.
//

import AsyncDisplayKit

class CategoryNode: ASCellNode {
  private let textNode: ASTextNode
  private let checkImageNode: ASImageNode?
  
  init(key: String, category: String, isSelected: Bool) {
    textNode = ASTextNode()
    textNode.maximumNumberOfLines = 1
    textNode.attributedText = NSAttributedString(
      string: category,
      attributes: [
        .font: UIFont.systemFont(ofSize: 14, weight: .regular),
        .foregroundColor: isSelected ? UIColor.black : UIColor.gray
      ]
    )
    
    if isSelected {
      checkImageNode = ASImageNode()
      checkImageNode?.image = UIImage(systemName: "checkmark.circle")
      checkImageNode?.style.preferredSize = CGSize(width: 16, height: 16)
    } else {
      checkImageNode = nil
    }
    
    super.init()
    automaticallyManagesSubnodes = true
    cornerRadius = 8
    borderWidth = 1
    borderColor = isSelected ? UIColor.black.cgColor : UIColor.gray.cgColor
  }
  
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let horizontalStack = ASStackLayoutSpec(
      direction: .horizontal,
      spacing: 4,
      justifyContent: .center,
      alignItems: .center,
      children: [textNode, checkImageNode].compactMap { $0 }
    )
    
    return ASInsetLayoutSpec(
      insets: UIEdgeInsets(
        top: 8,
        left: 16,
        bottom: 8,
        right: 16
      ),
      child: horizontalStack
    )
  }
}
