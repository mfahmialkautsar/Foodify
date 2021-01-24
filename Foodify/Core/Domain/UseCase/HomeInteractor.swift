//
//  HomeInteractor.swift
//  Foodify
//
//  Created by Jamal on 31/12/20.
//  Copyright © 2020 Kementerian Agama RI. All rights reserved.
//

import Combine
import Foundation

protocol HomeUseCase {
  func getCategories() -> AnyPublisher<[CategoryModel], Error>
}

class HomeInteractor: HomeUseCase {
  private let repository: DataRepositoryProtocol

  required init(repository: DataRepositoryProtocol) {
    self.repository = repository
  }

  func getCategories() -> AnyPublisher<[CategoryModel], Error> {
    repository.getCategories()
  }
}
