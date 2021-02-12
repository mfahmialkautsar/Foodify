//
//  ToMealRouter.swift
//  Foodify
//
//  Created by Jamal on 03/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import FoodifyCore
import FoodifyMeal
import Foundation
import UIKit

class ToMealRouter: Router {
  typealias Request = Meal

  func go(view: UIViewController, request: Meal?) {
    guard let meal = request else { return }
    let useCase: Interactor<
      String,
      MealModel,
      GetMealRepository<
        MealLocaleDataSource,
        MealRemoteDataSource,
        MealTransformer>> = Injection().provideMeal()
    let favoriteUseCase: Interactor<
      MealModel,
      Bool,
      DoFavoriteRepository<
        MealLocaleDataSource,
        MealTransformer
    >> = Injection().provideDoFavorite()
    let presenter = MealPresenter(useCase: useCase, favoriteUseCase: favoriteUseCase, meal: meal)
    let mealView = MealView(presenter: presenter)
    mealView.hidesBottomBarWhenPushed = true
    view.navigationController?.pushViewController(mealView, animated: true)
  }
}
