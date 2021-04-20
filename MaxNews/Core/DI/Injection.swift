//
//  Injection.swift
//  MaxNews
//
//  Created by Didik on 12/11/20.
//

import Swinject

final class Injection: NSObject {
  static let shared = Injection()
  
  private let container = Container()
  
  func register() {
    container.register(RemoteDataSourceImpl.self) { _ in
      RemoteDataSourceImpl.shared
    }
    
    container.register(LocaleDataSourceImpl.self) { _ in
      LocaleDataSourceImpl.shared
    }
    
    container.register(NewsRepositoryImpl.self) { resolver in
      NewsRepositoryImpl.shared(
        resolver.resolve(RemoteDataSourceImpl.self)!,
        resolver.resolve(LocaleDataSourceImpl.self)!
      )
    }
    
    container.register(NewsInteractor.self) { resolver in
      NewsInteractor(repository: resolver.resolve(NewsRepositoryImpl.self)!)
    }
    
    container.register(NewsPresenter.self) { resolver in
      NewsPresenter(homeUseCase: resolver.resolve(NewsInteractor.self)!)
    }
  }
  
  func provideNewsPresenter() -> NewsPresenter? {
    return container.resolve(NewsPresenter.self)
  }
}
