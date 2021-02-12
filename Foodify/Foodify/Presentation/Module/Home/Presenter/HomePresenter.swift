//
//  HomePresenter.swift
//  Foodify
//
//  Created by Jamal on 08/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Combine
import FoodifyCategory
import FoodifyCore
import UIKit

class HomePresenter<
  GetCategoriesInteractor: UseCase,
  ToMealsRouter: Router,
  ToSearchRouter: Router
>: ObservableObject
  where
  GetCategoriesInteractor.Request == String,
  GetCategoriesInteractor.Response == [CategoryModel],
  ToMealsRouter.Request == Category,
  ToSearchRouter.Request == Any {
  var cancellables = Set<AnyCancellable>()
  private let useCase: GetCategoriesInteractor
  private let toMealsRouter: ToMealsRouter
  private let toSearchRouter: ToSearchRouter

  @Published var state: State?
  @Published var categories = [Category]()

  init(
    useCase: GetCategoriesInteractor,
    toMealsRouter: ToMealsRouter,
    toSearchRouter: ToSearchRouter
  ) {
    self.useCase = useCase
    self.toMealsRouter = toMealsRouter
    self.toSearchRouter = toSearchRouter
  }

  func getCategories() {
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
      }, receiveValue: { categories in
        self.categories = self.mapped(categories)
        self.state = .success
      }).store(in: &cancellables)
  }

  func toMeals(for index: Int, view: UIViewController) {
    toMealsRouter.go(view: view, request: categories[index])
  }

  func toSearch(view: UIViewController) {
    toSearchRouter.go(view: view, request: nil)
  }
}

fileprivate extension HomePresenter {
  func mapped(_ domain: GetCategoriesInteractor.Response) -> [Category] {
    return CategoriesMapper().transformDomainToModel(domain: domain)
  }
}
