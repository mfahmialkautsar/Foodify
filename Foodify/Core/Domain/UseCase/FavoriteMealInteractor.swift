//
//  FavoriteMealInteractor.swift
//  Foodify
//
//  Created by Jamal on 04/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Combine
import Foundation

protocol FavoriteMealUseCase {
  func getFavoriteMeals() -> AnyPublisher<[Meal], Error>
}

class FavoriteMealInteractor: FavoriteMealUseCase {
  private let repository: DataRepositoryProtocol

  required init(repository: DataRepositoryProtocol) {
    self.repository = repository
  }

  func getFavoriteMeals() -> AnyPublisher<[Meal], Error> {
    repository.getFavorteMeals()
      .map { DomainMapper.mapMealsDomainToPresentation(input: $0) }
      .eraseToAnyPublisher()
  }
}
