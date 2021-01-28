//
//  HomeRouter.swift
//  Foodify
//
//  Created by Jamal on 01/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Foundation
import UIKit

class HomeRouter {
  private func getMealsUseCase() -> MealUseCase {
    return Injection().provideMeals()
  }

  func makeMealsByCategory(for category: Category) -> UIViewController {
    let mealsUseCase = getMealsUseCase()
    let presenter = MealPresenter(mealsUseCase: mealsUseCase)
    let mealsView = MealView(presenter: presenter)

    presenter.category = category
    return mealsView
  }

  func makeSearch() -> UIViewController {
    let searchUseCase = Injection().provideSearch()
    let presenter = SearchPresenter(searchUseCase: searchUseCase)
    return SearchView(presenter: presenter)
  }
}
