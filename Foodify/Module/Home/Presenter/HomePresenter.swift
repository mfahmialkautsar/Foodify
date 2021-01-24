//
//  HomePresenter.swift
//  Foodify
//
//  Created by Jamal on 31/12/20.
//  Copyright © 2020 Kementerian Agama RI. All rights reserved.
//

import Combine
import Foundation
import UIKit

class HomePresenter: ObservableObject {
  private let useCase: HomeUseCase
  private let router = HomeRouter()
  var cancellables: Set<AnyCancellable> = []

  @Published var state: State?
  @Published var categories: [CategoryModel] = []

  enum State: Equatable {
    static func == (lhs: HomePresenter.State, rhs: HomePresenter.State) -> Bool {
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

  init(homeUseCase: HomeUseCase) {
    useCase = homeUseCase
  }

  func getCategories() {
    guard state != State.loading else { return }
    state = .loading
    useCase.getCategories()
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
          break
        case let .failure(error):
          self.state = .error(error)
        }
      }, receiveValue: { categories in
        self.categories = categories
        self.state = .success
      }).store(in: &cancellables)
  }

  func toMeals(for index: Int, view: UIViewController) {
    view.navigationController?.pushViewController(router.makeMealsByCategory(for: categories[index]), animated: true)
  }

  func toSearch(view: UIViewController) {
    let searchViewController = router.makeSearch()
    view.navigationController?.present(
      UINavigationController(rootViewController: searchViewController),
      animated: true,
      completion: nil
    )
  }
}
