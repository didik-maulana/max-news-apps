//
//  NewsDetailViewController.swift
//  MaxNews
//
//  Created by Didik on 16/11/20.
//

import AsyncDisplayKit

class NewsDetailViewController: ASDKViewController<ASScrollNode> {
  
  private let titleNode: ASTextNode = {
    let node = ASTextNode()
    node.maximumNumberOfLines = 4
    node.truncationMode = .byTruncatingTail
    return node
  }()
  
  private let authorNode: ASTextNode = {
    let node = ASTextNode()
    node.maximumNumberOfLines = 2
    return node
  }()
  
  private let publishedDateNode: ASTextNode = {
    let node = ASTextNode()
    node.maximumNumberOfLines = 1
    return node
  }()
  
  private let imageNode: ASNetworkImageNode = {
    let node = ASNetworkImageNode()
    node.shouldRenderProgressImages = true
    return node
  }()
  
  private let descriptionNode: ASTextNode = ASTextNode()
  
  private let article: ArticleModel
  
  init(article: ArticleModel) {
    self.article = article
    
    super.init(node: ASScrollNode())
    node.automaticallyManagesSubnodes = true
    node.automaticallyManagesContentSize = true
    node.backgroundColor = .white
    
    titleNode.attributedText = NSAttributedString(
      string: article.title,
      attributes: [
        .font: UIFont.systemFont(ofSize: 24, weight: .bold),
        .foregroundColor: UIColor.black
      ]
    )
    
    authorNode.attributedText = NSAttributedString(
      string: "\(article.author) in \(article.source.name)",
      attributes: [
        .font: UIFont.systemFont(ofSize: 16, weight: .regular),
        .foregroundColor: UIColor.black
      ]
    )
    
    publishedDateNode.attributedText = NSAttributedString(
      string: article.publishedDate,
      attributes: [
        .font: UIFont.systemFont(ofSize: 14, weight: .regular),
        .foregroundColor: UIColor.gray
      ]
    )
    
    descriptionNode.attributedText = NSAttributedString(
      string: article.content,
      attributes: [
        .font: UIFont.systemFont(ofSize: 16, weight: .regular),
        .foregroundColor: UIColor.black
      ]
    )
    
    imageNode.url = article.imageURL
    
    node.layoutSpecBlock = { [weak self] _, size in
      guard let self = self else { return ASLayoutSpec() }
      
      self.imageNode.style.preferredSize = CGSize(width: size.max.width, height: 220)
      
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
          children: [self.authorNode, self.publishedDateNode]
        )
      )
      
      let headerInset = ASInsetLayoutSpec(
        insets: UIEdgeInsets(
          top: 16,
          left: 16,
          bottom: 16,
          right: 16
        ),
        child: ASStackLayoutSpec(
          direction: .vertical,
          spacing: 0,
          justifyContent: .start,
          alignItems: .start,
          children: [
            self.titleNode,
            authorPublishedInset,
          ]
        )
      )
      
      let descriptionInset = ASInsetLayoutSpec(
        insets: UIEdgeInsets(
          top: 16,
          left: 16,
          bottom: 16,
          right: 16
        ),
        child: self.descriptionNode
      )
      
      let contentStack = ASStackLayoutSpec(
        direction: .vertical,
        spacing: 0,
        justifyContent: .start,
        alignItems: .start,
        children: [
          headerInset,
          self.imageNode,
          descriptionInset
        ]
      )
      
      return contentStack
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let saveButton = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: nil)
    navigationItem.rightBarButtonItem = saveButton
    
    navigationController?.navigationBar.tintColor = .black
    navigationController?.navigationBar.isTranslucent = false
    
    self.title = article.source.name
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
