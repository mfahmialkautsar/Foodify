//
//  MealsPresenter.swift
//  Foodify
//
//  Created by Jamal on 09/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Combine
import FoodifyCategory
import FoodifyCore
import FoodifyMeal
import UIKit

class MealsPresenter<
  GetMealsInteractor: UseCase,
  ToMealRouter: Router
>: ObservableObject
  where
  GetMealsInteractor.Request == String,
  GetMealsInteractor.Response == [MealModel],
  ToMealRouter.Request == Meal {
  var cancellables = Set<AnyCancellable>()
  private let router: ToMealRouter
  private let useCase: GetMealsInteractor

  @Published var state: State?
  @Published var category: Category?
  @Published var meals = [Meal]()

  init(
    useCase: GetMealsInteractor,
    router: ToMealRouter
  ) {
    self.useCase = useCase
    self.router = router
  }

  func getMeals() {
    guard state != .loading,
      let categoryName = category?.name else { return }
    state = .loading
    useCase.execute(categoryName)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
          break
        case let .failure(error):
          self.state = .error(error)
        }
      }, receiveValue: { meals in
        self.meals = MealsMapper().transformDomainToModel(domain: meals)
        self.state = .success
      }
      ).store(in: &cancellables)
  }

  func toMeal(for index: Int, view: UIViewController) {
    router.go(view: view, request: meals[index])
  }
}
