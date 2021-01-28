//
//  MealInteractor.swift
//  Foodify
//
//  Created by Jamal on 01/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Combine
import Foundation

protocol MealUseCase {
  func getMealsByCategory(category: Category) -> AnyPublisher<[Meal], Error>
}

class MealInteractor: MealUseCase {
  private let repository: DataRepositoryProtocol

  init(repository: DataRepositoryProtocol) {
    self.repository = repository
  }

  func getMealsByCategory(category: Category) -> AnyPublisher<[Meal], Error> {
    repository.getMealsByCategory(category: category.name ?? "")
      .map { DomainMapper.mapMealsDomainToPresentation(input: $0) }
      .eraseToAnyPublisher()
  }
}
