//
//  TabBarController.swift
//  MaxNews
//
//  Created by Didik on 12/11/20.
//

import UIKit
import AsyncDisplayKit

class TabBarController: ASTabBarController {
  
  private var newsNavigationController: ASNavigationController {
    let title = "News"
    let newsViewController = NewsViewController()
    newsViewController.title = title
    newsViewController.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: "newspaper"), tag: 1)
    return ASNavigationController(rootViewController: newsViewController)
  }
  
  private var searchNavigationController: ASNavigationController {
    let title = "Search"
    let searchViewController = SearchViewController()
    searchViewController.title = title
    searchViewController.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: "magnifyingglass.circle"), tag: 1)
    return ASNavigationController(rootViewController: searchViewController)
  }
  
  private var profileNavigationController: ASNavigationController {
    let title = "Profile"
    let profileViewController = ProfileViewController()
    profileViewController.title = title
    profileViewController.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: "person.circle"), tag: 2)
    return ASNavigationController(rootViewController: profileViewController)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    UITabBar.appearance().tintColor = .black
    
    self.viewControllers = [
      newsNavigationController,
      searchNavigationController,
      profileNavigationController
    ]
  }
}
