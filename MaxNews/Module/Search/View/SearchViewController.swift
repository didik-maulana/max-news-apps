//
//  SearchViewController.swift
//  MaxNews
//
//  Created by Didik on 12/11/20.
//

import AsyncDisplayKit

class SearchViewController: ASDKViewController<ASDisplayNode> {
  
  private let articlesTableNode: ASTableNode = {
    let node = ASTableNode()
    node.allowsMultipleSelection = false
    node.view.separatorStyle = .none
    return node
  }()
  
  private let searchNode: ASEditableTextNode = {
    let node = ASEditableTextNode()
    return node
  }()
  
  override init() {
    super.init(node: ASDisplayNode())
    node.automaticallyManagesSubnodes = true
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .red
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
