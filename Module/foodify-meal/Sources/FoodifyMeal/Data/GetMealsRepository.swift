//
//  MealsRepository.swift
//  Foodify
//
//  Created by Jamal on 08/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Combine
import FoodifyCore

public struct GetMealsRepository<
  MealLocaleDataSource,
  MealRemoteDataSource: RemoteDataSource,
  Transformer: Mapper>: Repository
  where
  MealRemoteDataSource.Request == String,
  MealRemoteDataSource.Response == [MealResponse],
  Transformer.Response == [MealResponse],
  Transformer.Entity == [MealEntity],
  Transformer.Domain == [MealModel] {
  public typealias Request = String
  public typealias Response = [MealModel]

  private let localeDataSource: MealLocaleDataSource
  private let remoteDataSource: MealRemoteDataSource
  private let mapper: Transformer

  public init(
    localeDataSource: MealLocaleDataSource,
    remoteDataSource: MealRemoteDataSource,
    mapper: Transformer
  ) {
    self.localeDataSource = localeDataSource
    self.remoteDataSource = remoteDataSource
    self.mapper = mapper
  }

  public func execute(request: String?) -> AnyPublisher<[MealModel], Error> {
    remoteDataSource.get(request: request ?? "")
      .map { self.mapper.transformResponseToDomain(response: $0) }
      .eraseToAnyPublisher()
  }
}
