//
//  Injection.swift
//  Foodify
//
//  Created by Jamal on 31/12/20.
//  Copyright © 2020 Kementerian Agama RI. All rights reserved.
//

import FoodifyCategory
import FoodifyCore
import FoodifyMeal
import Foundation
import RealmSwift
import UIKit

final class Injection: NSObject {
  func provideHome<U: UseCase>() -> U
    where U.Request == String, U.Response == [CategoryModel] {
    let remote = GetCategoriesRemoteDataSource(endpoint: { _ in Endpoints.Gets.categories.url })
    let mapper = CategoriesTransformer()
    let repository = GetCategoriesRepository<
      Any,
      GetCategoriesRemoteDataSource,
      CategoriesTransformer
    >(
      remoteDataSource: remote,
      mapper: mapper
    )
    return Interactor(repository: repository) as! U
  }

  func provideMeals<U: UseCase>(url: @escaping (String) -> (String)) -> U
    where U.Request == String, U.Response == [MealModel] {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let locale = MealLocaleDataSource(realm: appDelegate.realm)
    let remote = MealsRemoteDataSource(endpoint: url)
    let mapper = MealsTransformer()
    let repository = GetMealsRepository(localeDataSource: locale, remoteDataSource: remote, mapper: mapper)
    return Interactor(repository: repository) as! U
  }

  func provideMeal<U: UseCase>() -> U
    where U.Request == String, U.Response == MealModel {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let locale = MealLocaleDataSource(realm: appDelegate.realm)
    let remote = MealRemoteDataSource(endpoint: { Endpoints.Gets.byId($0).url })
    let mapper = MealTransformer()
    let repository = GetMealRepository(localeDataSource: locale, remoteDataSource: remote, mapper: mapper)
    return Interactor(repository: repository) as! U
  }

  func provideDoFavorite<U: UseCase>() -> U
    where U.Request == MealModel, U.Response == Bool {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let locale = MealLocaleDataSource(realm: appDelegate.realm)
    let mapper = MealTransformer()
    let repository = DoFavoriteRepository(localeDataSource: locale, mapper: mapper)
    return Interactor(repository: repository) as! U
  }

  func provideFavorite<U: UseCase>() -> U
    where U.Request == Any, U.Response == [MealModel] {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let locale = MealLocaleDataSource(realm: appDelegate.realm)
    let mapper = MealsTransformer()
    let repository = GetFavoriteMealsRepository(localeDataSource: locale, mapper: mapper)
    return Interactor(repository: repository) as! U
  }

  func provideProfile<U: UseCase>() -> U {
    return U.self as! U
  }
}
