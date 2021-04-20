//
//  NewsViewController.swift
//  MaxNews
//
//  Created by Didik on 12/11/20.
//

import AsyncDisplayKit
import Combine

class NewsViewController: ASDKViewController<ASDisplayNode> {
  
  private let categoriesCollectionNode: ASCollectionNode = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.minimumInteritemSpacing = 8
    flowLayout.scrollDirection = .horizontal
    
    let node = ASCollectionNode.init(collectionViewLayout: flowLayout)
    node.allowsMultipleSelection = false
    node.showsHorizontalScrollIndicator = false
    node.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    return node
  }()
  
  private let articlesTableNode: ASTableNode = {
    let node = ASTableNode()
    node.allowsMultipleSelection = false
    node.style.flexGrow = 1
    node.view.separatorStyle = .none
    return node
  }()

  private let presenter: NewsPresenter? = {
    let injection = Injection.shared.provideNewsPresenter()
    return injection
  }()
  
  private var categories: [CategoryModel] = []
  private var articles: [ArticleModel] = []
  private var cancelables: Set<AnyCancellable> = []
  
  override init() {
    super.init(node: ASDisplayNode())
    node.automaticallyManagesSubnodes = true
    node.backgroundColor = .white
    renderNode()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupCategoriesCollectionView()
    setupArticlesTableView()
    observePublisher()
    presenter?.getCategories()
    
    let favoriteButtonBar = UIBarButtonItem(image: UIImage(systemName: "bookmark.fill"), style: .plain, target: self, action: nil)
    navigationItem.rightBarButtonItem = favoriteButtonBar

    navigationController?.navigationBar.tintColor = .black
    navigationController?.navigationBar.isTranslucent = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension NewsViewController {
  private func setupCategoriesCollectionView() {
    categoriesCollectionNode.dataSource = self
    categoriesCollectionNode.delegate = self
  }
  
  private func setupArticlesTableView() {
    articlesTableNode.dataSource = self
    articlesTableNode.delegate = self
  }
  
  private func renderNode() {
    node.layoutSpecBlock = { [weak self] _, size in
      guard let self = self else { return ASLayoutSpec() }
      
      self.categoriesCollectionNode.style.preferredSize = CGSize(width: size.max.width, height: 50)
      
      return ASStackLayoutSpec(
        direction: .vertical,
        spacing: 0,
        justifyContent: .start,
        alignItems: .start,
        children: [self.categoriesCollectionNode, self.articlesTableNode]
      )
    }
  }
  
  private func observePublisher() {
    presenter?.$isLoading.sink(receiveValue: { isLoading in
      print("Loading state = \(isLoading)")
    }).store(in: &cancelables)
    
    presenter?.$message.sink(receiveValue: { message in
      guard let message = message else { return }
      print("Error = \(message)")
    }).store(in: &cancelables)
    
    presenter?.$categories.sink(receiveValue: { [weak self] categories in
      guard let self = self else { return }
      
      if (!categories.isEmpty) {
        self.categories = categories
        self.categoriesCollectionNode.reloadData()
        self.getArticles()
      }
    }).store(in: &cancelables)
    
    presenter?.$articles.sink(receiveValue: { [weak self] articles in
      guard let self = self else { return }
      
      if (!articles.isEmpty) {
        self.articles = articles
        self.articlesTableNode.reloadData()
      }
    }).store(in: &cancelables)
  }
  
  private func getArticles() {
    let categorySelected = categories.first(where: { $0.isSelected })?.key
    presenter?.getArticles(category: categorySelected)
  }
}

extension NewsViewController: ASCollectionDataSource {
  func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
    return categories.count
  }
  
  func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
    let category = categories[indexPath.row]
    let cellNodeBlock = { () -> ASCellNode in
      let cellNode = CategoryNode(key: category.key, category: category.category, isSelected: category.isSelected)
      return cellNode
    }
    return cellNodeBlock
  }
}

extension NewsViewController: ASCollectionDelegate {
  func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
    for (index, category) in categories.enumerated() {
      categories[index].isSelected = false
      
      if category.key == categories[indexPath.row].key {
        categories[index].isSelected = true
      }
    }
    
    categoriesCollectionNode.deselectItem(at: indexPath, animated: true)
    categoriesCollectionNode.reloadData()
    
    articlesTableNode.setContentOffset(.zero, animated: true)
    getArticles()
  }
}

extension NewsViewController: ASTableDataSource {
  func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
    return articles.count
  }
  
  func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
    let article = articles[indexPath.row]
    let cellNodeBlock = { () -> ASCellNode in
      let cellNode = ArticleCardNode(article: article)
      return cellNode
    }
    return cellNodeBlock
  }
}

extension NewsViewController: ASTableDelegate {
  func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
    articlesTableNode.deselectRow(at: indexPath, animated: true)
    
    let detailViewController = NewsDetailViewController(article: articles[indexPath.row])
    detailViewController.hidesBottomBarWhenPushed = true
    navigationController?.pushViewController(detailViewController, animated: true)
  }
}
