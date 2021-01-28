//
//  Injection.swift
//  Foodify
//
//  Created by Jamal on 31/12/20.
//  Copyright © 2020 Kementerian Agama RI. All rights reserved.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
  private func provideRepository() -> DataRepositoryProtocol {
    let realm = try? Realm()
    let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance
    return DataRepository.sharedInstance(locale, remote)
  }

  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }

  func provideMeals() -> MealUseCase {
    let repository = provideRepository()
    return MealInteractor(repository: repository)
  }

  func provideDetail(meal: Meal) -> DetailUseCase {
    let repository = provideRepository()
    return DetailInteractor(repository: repository, meal: meal)
  }

  func provideFavorite() -> FavoriteMealUseCase {
    let repository = provideRepository()
    return FavoriteMealInteractor(repository: repository)
  }

  func provideSearch() -> SearchUseCase {
    let repository = provideRepository()
    return SearchInteractor(repository: repository)
  }
}
