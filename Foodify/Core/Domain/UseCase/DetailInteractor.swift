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
  func getDetail() -> AnyPublisher<Detail, Error>
  func favorite(_ details: Detail) -> AnyPublisher<Bool, Error>
}

class DetailInteractor: DetailUseCase {
  private let repository: DataRepositoryProtocol
  private let meal: Meal

  required init(repository: DataRepositoryProtocol, meal: Meal) {
    self.repository = repository
    self.meal = meal
  }

  func getDetail() -> AnyPublisher<Detail, Error> {
    repository.getDetail(id: meal.id ?? "")
      .map { DomainMapper.mapDetailDomainToPresentation(input: $0) }
      .eraseToAnyPublisher()
  }

  func favorite(_ detail: Detail) -> AnyPublisher<Bool, Error> {
    repository.favorite(detail: PresentationMapper.mapDetailPresentationToDomain(input: detail))
  }
}
