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
  private func getMealsUseCase() -> MealsUseCase {
    return Injection().provideMeals()
  }

  func makeMealsByCategory(for category: CategoryModel) -> UIViewController {
    let mealsUseCase = getMealsUseCase()
    let presenter = MealsPresenter(mealsUseCase: mealsUseCase)
    let mealsView = MealsView(presenter: presenter)

    presenter.category = category
    return mealsView
  }

  func makeSearch() -> UIViewController {
    let searchUseCase = Injection().provideSearch()
    let presenter = SearchPresenter(searchUseCase: searchUseCase)
    return SearchView(presenter: presenter)
  }
}
