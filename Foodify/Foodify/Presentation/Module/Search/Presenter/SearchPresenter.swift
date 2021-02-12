//
//  SearchPresenter.swift
//  Foodify
//
//  Created by Jamal on 23/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Combine
import FoodifyCore
import FoodifyMeal
import Foundation
import UIKit

class SearchPresenter<
  GetMealsInteractor: UseCase,
  ToMealRouter: Router
>: ObservableObject
  where
  GetMealsInteractor.Request == String,
  GetMealsInteractor.Response == [MealModel],
  ToMealRouter.Request == Meal {
  private let searchUseCase: GetMealsInteractor
  private let router: ToMealRouter
  private var keyword = "" {
    didSet {
      state = .loading
      debouncer.call()
    }
  }

  var cancellables = Set<AnyCancellable>()

  private lazy var debouncer = Debouncer(delay: 0.3) {
    self.searchMeal(name: self.keyword)
  }

  @Published var state: State?
  @Published var meals = [Meal]()

  init(
    searchUseCase: GetMealsInteractor,
    router: ToMealRouter
  ) {
    self.searchUseCase = searchUseCase
    self.router = router
  }

  func search(keyword: String) {
    self.keyword = keyword
  }

  func getKeyword() -> String {
    return keyword
  }

  func toDetail(for index: Int, view: UIViewController) {
    router.go(view: view, request: meals[index])
  }
}

fileprivate extension SearchPresenter {
  func searchMeal(name: String) {
    state = .loading
    searchUseCase.execute(name).sink(receiveCompletion: { completion in
      switch completion {
      case .finished:
        break
      case let .failure(error):
        guard error.localizedDescription != "Request explicitly cancelled." else { return }
        self.state = .error(error)
      }
    }, receiveValue: { details in
      self.meals = MealsMapper().transformDomainToModel(domain: details)
      self.state = .success
    }).store(in: &cancellables)
  }
}
