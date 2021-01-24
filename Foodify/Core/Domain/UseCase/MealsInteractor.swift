//
//  MealsInteractor.swift
//  Foodify
//
//  Created by Jamal on 01/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Combine
import Foundation

protocol MealsUseCase {
  func getMealsByCategory(category: CategoryModel) -> AnyPublisher<[MealModel], Error>
}

class MealsInteractor: MealsUseCase {
  private let repository: DataRepositoryProtocol

  init(repository: DataRepositoryProtocol) {
    self.repository = repository
  }

  func getMealsByCategory(category: CategoryModel) -> AnyPublisher<[MealModel], Error> {
    repository.getMealsByCategory(category: category.name ?? "")
  }
}
