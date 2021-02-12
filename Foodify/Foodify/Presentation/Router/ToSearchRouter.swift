//
//  ToSearchRouter.swift
//  Foodify
//
//  Created by Jamal on 12/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import FoodifyCore
import FoodifyMeal
import Foundation
import UIKit

class ToSearchRouter: Router {
  typealias Request = Any

  func go(view: UIViewController, request: Any?) {
    let useCase: Interactor<
      String,
      [MealModel],
      GetMealsRepository<
        MealLocaleDataSource,
        MealsRemoteDataSource,
        MealsTransformer>> = Injection().provideMeals(url: { Endpoints.Gets.byName($0).url })
    let presenter = SearchPresenter(searchUseCase: useCase, router: ToMealRouter())
    let searchView = SearchView(presenter: presenter)
    view.navigationController?.present(
      UINavigationController(rootViewController: searchView),
      animated: true,
      completion: nil
    )
  }
}
