//
//  SearchPresenter.swift
//  Foodify
//
//  Created by Jamal on 23/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Combine
import Foundation
import UIKit

class SearchPresenter: ObservableObject {
  private let searchUseCase: SearchUseCase
  private let router = SearchRouter()
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
  @Published var details = [DetailModel]()

  enum State: Equatable {
    static func == (lhs: SearchPresenter.State, rhs: SearchPresenter.State) -> Bool {
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

  init(searchUseCase: SearchUseCase) {
    self.searchUseCase = searchUseCase
  }

  func search(keyword: String) {
    self.keyword = keyword
  }

  func getKeyword() -> String {
    return keyword
  }

  func toDetail(for index: Int, view: UIViewController) {
    view.navigationController?.pushViewController(router.makeDetails(detail: details[index]), animated: true)
  }
}

fileprivate extension SearchPresenter {
  func searchMeal(name: String) {
    state = .loading
    searchUseCase.getSearch(name: name).sink(receiveCompletion: { completion in
      switch completion {
      case .finished:
        break
      case let .failure(error):
        guard error.localizedDescription != "Request explicitly cancelled." else { return }
        self.state = .error(error)
      }
    }, receiveValue: { details in
      self.details = details ?? []
      self.state = .success
    }).store(in: &cancellables)
  }
}
