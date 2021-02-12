//
//  DoFavoriteRepository.swift
//  Foodify
//
//  Created by Jamal on 10/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Combine
import FoodifyCore

public struct DoFavoriteRepository<
  MealLocaleDataSource: LocaleDataSource,
  Transformer: Mapper
>: Repository
  where
  MealLocaleDataSource.Response == Transformer.Entity,
  Transformer.Entity == MealEntity,
  Transformer.Domain == MealModel {
  public typealias Request = Transformer.Domain
  public typealias Response = Bool

  private let localeDataSource: MealLocaleDataSource
  private let mapper: Transformer

  public init(
    localeDataSource: MealLocaleDataSource,
    mapper: Transformer
  ) {
    self.localeDataSource = localeDataSource
    self.mapper = mapper
  }

  public func execute(request: Transformer.Domain?) -> AnyPublisher<Bool, Error> {
    guard let request = request else { fatalError() }
    return localeDataSource.update(entity: mapper.transformDomainToEntity(domain: request))
  }
}
