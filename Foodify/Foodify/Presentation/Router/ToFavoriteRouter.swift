//
//  ToFavoriteRouter.swift
//  Foodify
//
//  Created by Jamal on 11/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import FoodifyCore
import FoodifyMeal
import Foundation
import UIKit

class ToFavoriteRouter: Router {
  typealias Request = Any

  func go(view: UIViewController, request: Any?) {
    let favoriteUseCase: Interactor<
      Any,
      [MealModel],
      GetFavoriteMealsRepository<
        MealLocaleDataSource,
        MealsTransformer>> = Injection().provideFavorite()
    let presenter = FavoritePresenter(useCase: favoriteUseCase, router: ToMealRouter())
    let favoriteMealView = FavoriteMealView(presenter: presenter)
    view.navigationController?.pushViewController(favoriteMealView, animated: true)
  }
}
