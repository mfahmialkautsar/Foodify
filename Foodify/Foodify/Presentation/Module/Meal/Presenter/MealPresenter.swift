//
//  MealPresenter.swift
//  Foodify
//
//  Created by Jamal on 09/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Combine
import FoodifyCore
import FoodifyMeal

class MealPresenter<
  GetMealInteractor: UseCase,
  FavoriteInteractor: UseCase
>: ObservableObject
  where
  GetMealInteractor.Request == String,
  GetMealInteractor.Response == MealModel,
  FavoriteInteractor.Request == GetMealInteractor.Response,
  FavoriteInteractor.Response == Bool {
  var cancellables = Set<AnyCancellable>()
  private let useCase: GetMealInteractor
  private let favoriteUseCase: FavoriteInteractor

  @Published var state: State?
  @Published var meal: Meal

  init(useCase: GetMealInteractor, favoriteUseCase: FavoriteInteractor, meal: Meal) {
    self.useCase = useCase
    self.favoriteUseCase = favoriteUseCase
    self.meal = meal
  }

  func getMeal() {
//    guard let meal = meal as? Meal, let request = meal.id as? GetMealInteractor.Request? else { return }
    guard state != .loading else { return }
    state = .loading
    useCase.execute(meal.id)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
          break
        case let .failure(error):
          self.state = .error(error)
        }
      }, receiveValue: { meal in
        self.meal = MealMapper().transformDomainToModel(domain: meal)
        self.state = .success
      }).store(in: &cancellables)
  }

  func favorite() {
//      guard let details = detail else { return }
//    guard let meal = meal as? Meal, let request = meal.id as? Request? else { return }
    guard state != .loading else { return }
    state = .loading
    favoriteUseCase.execute(MealMapper().transformModelToDomain(model: meal))
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
          self.state = .success
        case let .failure(error):
          self.state = .error(error)
        }
      }, receiveValue: { result in
        self.meal.favorited = result
      }).store(in: &cancellables)
  }
}
