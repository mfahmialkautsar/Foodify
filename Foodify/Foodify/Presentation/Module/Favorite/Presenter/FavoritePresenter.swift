//
//  FavoritePresenter.swift
//  Foodify
//
//  Created by Jamal on 09/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Combine
import FoodifyCore
import FoodifyMeal
import UIKit

class FavoritePresenter<
  GetFavMealsInteractor: UseCase,
  ToMealRouter: Router
>: ObservableObject
  where
  GetFavMealsInteractor.Response == [MealModel],
  ToMealRouter.Request == Meal {
  var cancellables = Set<AnyCancellable>()
  private let router: ToMealRouter
  private var keyword = "" {
    didSet {
      getMealsByName(keyword: keyword)
    }
  }

  private let useCase: GetFavMealsInteractor

  @Published private var storedMeals = [Meal]()
  @Published private var meals: [Meal]?
  @Published var state: State?

  init(
    useCase: GetFavMealsInteractor,
    router: ToMealRouter
  ) {
    self.useCase = useCase
    self.router = router
  }

  func fetchMeals() {
    guard state != .loading else { return }
    state = .loading
    useCase.execute(nil)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
          break
        case let .failure(error):
          self.state = .error(error)
        }
      }, receiveValue: { meals in
        self.storedMeals = MealsMapper().transformDomainToModel(domain: meals)
        self.state = .success
      }).store(in: &cancellables)
  }

  func getMeals() -> [Meal] {
    return meals ?? storedMeals
  }

  func getKeyword() -> String {
    return keyword
  }

  func search(keyword: String) {
    self.keyword = keyword
  }

  func toDetails(for index: Int, view: UIViewController) {
    router.go(view: view, request: getMeals()[index])
  }
}

fileprivate extension FavoritePresenter {
  func getMealsByName(keyword: String) {
    state = .loading
    guard !keyword.isEmpty else {
      meals = nil
      state = .success
      return
    }
    meals = storedMeals.filter {
      guard let name = $0.name?.lowercased() else { return false }
      return name.contains(keyword.lowercased())
    }
    state = .success
  }
}
