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
  func getFavoriteMeals() -> AnyPublisher<[MealModel], Error>
}

class FavoriteMealInteractor: FavoriteMealUseCase {
  private let repository: DataRepositoryProtocol

  required init(repository: DataRepositoryProtocol) {
    self.repository = repository
  }

  func getFavoriteMeals() -> AnyPublisher<[MealModel], Error> {
    repository.getFavorteMeals()
  }
}
