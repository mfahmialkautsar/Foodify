//
//  MealPresenter.swift
//  Foodify
//
//  Created by Jamal on 02/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Combine
import Foundation
import UIKit

class MealPresenter: ObservableObject {
  private let mealsUseCase: MealUseCase
  private let router = MealRouter()
  var cancellables: Set<AnyCancellable> = []

  @Published var state: State?
  @Published var category: Category?
  @Published var meals = [Meal]()

  enum State: Equatable {
    static func == (lhs: MealPresenter.State, rhs: MealPresenter.State) -> Bool {
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

  init(mealsUseCase: MealUseCase) {
    self.mealsUseCase = mealsUseCase
  }

  func getMeals() {
    guard state != .loading else { return }
    state = .loading
    guard let category = category else { return }
    mealsUseCase.getMealsByCategory(category: category)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
          break
        case let .failure(error):
          self.state = .error(error)
        }
      }, receiveValue: { meals in
        self.meals = meals
        self.state = .success
      }
      ).store(in: &cancellables)
  }

  func toDetails(for index: Int, view: UIViewController) {
    view.navigationController?.pushViewController(router.makeDetail(meal: meals[index]), animated: true)
  }
}
