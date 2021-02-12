//
//  GetFavoriteMealsRepository.swift
//  Foodify
//
//  Created by Jamal on 09/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Combine
import FoodifyCore

public struct GetFavoriteMealsRepository<
  MealLocaleDataSource: LocaleDataSource,
  Transformer: Mapper>: Repository
  where
  MealLocaleDataSource.Response == MealEntity,
  Transformer.Response == [MealResponse],
  Transformer.Entity == [MealEntity],
  Transformer.Domain == [MealModel] {
  public typealias Request = MealLocaleDataSource.Request
  public typealias Response = [MealModel]

  private let localeDataSource: MealLocaleDataSource
  private let mapper: Transformer

  public init(
    localeDataSource: MealLocaleDataSource,
    mapper: Transformer
  ) {
    self.localeDataSource = localeDataSource
    self.mapper = mapper
  }

  public func execute(request: MealLocaleDataSource.Request?) -> AnyPublisher<[MealModel], Error> {
    localeDataSource.list(request: request)
      .map { (self.mapper.transformEntityToDomain(entity: $0)) }
      .eraseToAnyPublisher()
  }
}
