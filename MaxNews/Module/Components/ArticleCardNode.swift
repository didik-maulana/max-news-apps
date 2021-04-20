//
//  ArticleCardNode.swift
//  MaxNews
//
//  Created by Didik on 13/11/20.
//

import AsyncDisplayKit

class ArticleCardNode: ASCellNode {
  private let titleNode: ASTextNode
  private let authorNode: ASTextNode
  private let publishedDateNode: ASTextNode
  private let imageNode: ASNetworkImageNode
  
  init(article: ArticleModel) {
    titleNode = ASTextNode()
    authorNode = ASTextNode()
    publishedDateNode = ASTextNode()
    imageNode = ASNetworkImageNode()
    
    super.init()
    automaticallyManagesSubnodes = true
    
    renderTitleNode(article.title)
    renderAuthorNode(article.author, article.source.name)
    renderPublishedDateNode(article.publishedDate)
    renderImageNode(article.imageURL)
  }
  
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let authorPublishedInset = ASInsetLayoutSpec(
      insets: UIEdgeInsets(
        top: 20,
        left: 0,
        bottom: 0,
        right: 0
      ),
      child: ASStackLayoutSpec(
        direction: .vertical,
        spacing: 4,
        justifyContent: .start,
        alignItems: .start,
        children: [authorNode, publishedDateNode]
      )
    )
    
    let verticalStack = ASStackLayoutSpec(
      direction: .vertical,
      spacing: 4,
      justifyContent: .start,
      alignItems: .start,
      children: [titleNode, authorPublishedInset]
    )
    verticalStack.style.flexGrow = 1
    verticalStack.style.flexShrink = 1
    
    let horizontalInset = ASInsetLayoutSpec(
      insets: UIEdgeInsets(
        top: 16,
        left: 16,
        bottom: 16,
        right: 16
      ),
      child: ASStackLayoutSpec(
        direction: .horizontal,
        spacing: 12,
        justifyContent: .start,
        alignItems: .start,
        children: [verticalStack, imageNode]
      )
    )
    
    let dividerNode = ASDisplayNode()
    dividerNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 1)
    dividerNode.style.flexShrink = 1
    dividerNode.style.flexGrow = 1
    dividerNode.backgroundColor = .systemGray5
    
    let articleStack = ASStackLayoutSpec(
      direction: .vertical,
      spacing: 4,
      justifyContent: .start,
      alignItems: .start,
      children: [horizontalInset, dividerNode]
    )
    
    return articleStack
  }
  
  private func renderTitleNode(_ title: String) {
    titleNode.maximumNumberOfLines = 4
    titleNode.truncationMode = .byTruncatingTail
    titleNode.attributedText = NSAttributedString(
      string: title,
      attributes: [
        .font: UIFont.systemFont(ofSize: 16, weight: .semibold),
        .foregroundColor: UIColor.black
      ]
    )
  }
  
  private func renderAuthorNode(_ author: String, _ sourceName: String) {
    authorNode.maximumNumberOfLines = 2
    authorNode.attributedText = NSAttributedString(
      string: "\(author) in \(sourceName)",
      attributes: [
        .font: UIFont.systemFont(ofSize: 14, weight: .regular),
        .foregroundColor: UIColor.black
      ]
    )
  }
  
  private func renderPublishedDateNode(_ publishedDate: String) {
    publishedDateNode.maximumNumberOfLines = 1
    publishedDateNode.attributedText = NSAttributedString(
      string: publishedDate,
      attributes: [
        .font: UIFont.systemFont(ofSize: 12, weight: .regular),
        .foregroundColor: UIColor.gray
      ]
    )
  }
  
  private func renderImageNode(_ imageURL: URL?) {
    imageNode.style.preferredSize = CGSize(width: 100, height: 100)
    imageNode.cornerRadius = 4
    imageNode.shouldRenderProgressImages = true
    imageNode.url = imageURL
  }
}
