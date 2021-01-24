//
//  DetailInteractor.swift
//  Foodify
//
//  Created by Jamal on 01/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Combine
import Foundation

protocol DetailUseCase {
  func getDetail() -> AnyPublisher<DetailModel, Error>
  func favorite(_ details: DetailModel) -> AnyPublisher<Bool, Error>
}

class DetailInteractor: DetailUseCase {
  private let repository: DataRepositoryProtocol
  private let meal: MealModel

  required init(repository: DataRepositoryProtocol, meal: MealModel) {
    self.repository = repository
    self.meal = meal
  }

  func getDetail() -> AnyPublisher<DetailModel, Error> {
    return repository.getDetail(id: meal.id ?? "")
  }

  func favorite(_ details: DetailModel) -> AnyPublisher<Bool, Error> {
    return repository.favorite(details: details)
  }
}
