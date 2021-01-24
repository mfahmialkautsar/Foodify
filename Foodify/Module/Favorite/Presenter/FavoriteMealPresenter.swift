//
//  FavoriteMealPresenter.swift
//  Foodify
//
//  Created by Jamal on 03/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Combine
import Foundation
import UIKit

class FavoriteMealPresenter: ObservableObject {
  private let favoriteMealUseCase: FavoriteMealUseCase
  private let router = FavoriteMealRouter()
  private var keyword = "" {
    didSet {
      getMealsByName(keyword: keyword)
    }
  }

  var cancellables: Set<AnyCancellable> = []

  @Published private var storedMeals = [MealModel]()
  @Published var state: State?
  @Published var meals: [MealModel]?

  enum State: Equatable {
    static func == (lhs: FavoriteMealPresenter.State, rhs: FavoriteMealPresenter.State) -> Bool {
      switch (lhs, rhs) {
      case (.loading, .loading):
        return true
      default:
        return false
      }
    }

    case loading
    case success
    case error(Error)
  }

  init(favoriteMealUseCase: FavoriteMealUseCase) {
    self.favoriteMealUseCase = favoriteMealUseCase
  }

  func getMeals() -> [MealModel] {
    return meals ?? storedMeals
  }

  func fetchMeals() {
    guard state != .loading else { return }
    state = .loading
    favoriteMealUseCase.getFavoriteMeals()
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
          break
        case let .failure(error):
          self.state = .error(error)
        }
      }, receiveValue: { meals in
        self.storedMeals = meals
        self.state = .success
      }).store(in: &cancellables)
  }

  func getKeyword() -> String {
    return keyword
  }

  func search(keyword: String) {
    self.keyword = keyword
  }

  func toDetails(for index: Int, view: UIViewController) {
    view
      .navigationController?
      .pushViewController(router.makeDetail(meal: meals?[index] ?? storedMeals[index]), animated: true)
  }
}

fileprivate extension FavoriteMealPresenter {
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
