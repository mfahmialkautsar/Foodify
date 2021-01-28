//
//  DetailPresenter.swift
//  Foodify
//
//  Created by Jamal on 01/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Combine
import Foundation

class DetailPresenter: ObservableObject {
  private let detailsUseCase: DetailUseCase
  var cancellables: Set<AnyCancellable> = []

  @Published var state: State?
  @Published var detail: Detail?

  enum State: Equatable {
    static func == (lhs: DetailPresenter.State, rhs: DetailPresenter.State) -> Bool {
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

  init(detailUseCase: DetailUseCase) {
    detailsUseCase = detailUseCase
  }

  func getDetails() {
    guard state != .loading else { return }
    state = .loading
    detailsUseCase.getDetail()
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
          break
        case let .failure(error):
          self.state = .error(error)
        }
      }, receiveValue: { details in
        self.detail = details
        self.state = .success
      }).store(in: &cancellables)
  }

  func favorite() {
    guard let details = detail else { return }
    state = .loading
    detailsUseCase.favorite(details).sink(receiveCompletion: { completion in
      switch completion {
      case .finished:
        self.state = .success
      case let .failure(error):
        self.state = .error(error)
      }
    }, receiveValue: { result in
      self.detail?.favorited = result
    }).store(in: &cancellables)
  }
}
