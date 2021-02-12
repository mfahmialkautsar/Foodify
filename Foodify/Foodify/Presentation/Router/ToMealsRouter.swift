//
//  ToMealsRouter.swift
//  Foodify
//
//  Created by Jamal on 01/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import FoodifyCategory
import FoodifyCore
import FoodifyMeal
import Foundation
import UIKit

class ToMealsRouter: Router {
  typealias Request = Category

  func go(view: UIViewController, request: Category?) {
    guard let category = request else { return }
    let useCase: Interactor<
      String,
      [MealModel],
      GetMealsRepository<
        MealLocaleDataSource,
        MealsRemoteDataSource,
        MealsTransformer>> = Injection().provideMeals(url: { Endpoints.Gets.byCategory($0).url })
    let mealsPresenter = MealsPresenter(useCase: useCase, router: ToMealRouter())
    mealsPresenter.category = category
    let mealsView = MealsView(presenter: mealsPresenter)
    view.navigationController?.pushViewController(mealsView, animated: true)
  }
}
