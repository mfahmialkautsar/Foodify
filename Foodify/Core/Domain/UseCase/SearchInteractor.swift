//
//  SearchInteractor.swift
//  Foodify
//
//  Created by Jamal on 23/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Combine
import Foundation

protocol SearchUseCase {
  func getSearch(name: String) -> AnyPublisher<[DetailModel]?, Error>
}

class SearchInteractor: SearchUseCase {
  private let repository: DataRepositoryProtocol

  init(repository: DataRepositoryProtocol) {
    self.repository = repository
  }

  func getSearch(name: String) -> AnyPublisher<[DetailModel]?, Error> {
    repository.getMealsByName(name: name)
  }
}
