//
//  GetMealRepository.swift
//  Foodify
//
//  Created by Jamal on 07/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Combine
import FoodifyCore

public struct GetMealRepository<
  MealLocaleDataSource: LocaleDataSource,
  MealRemoteDataSource: RemoteDataSource,
  Transformer: Mapper>: Repository
  where
  MealLocaleDataSource.Response == MealEntity,
  MealRemoteDataSource.Request == String,
  MealRemoteDataSource.Response == MealResponse,
  Transformer.Response == MealRemoteDataSource.Response,
  Transformer.Entity == MealLocaleDataSource.Response,
  Transformer.Domain == MealModel {
  public typealias Request = MealRemoteDataSource.Request
  public typealias Response = MealModel

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

  public func execute(request: String?) -> AnyPublisher<MealModel, Error> {
    guard let request = request else { fatalError() }
    return localeDataSource.get(id: request)
      .flatMap { result -> AnyPublisher<MealModel, Error> in
        if let result = result {
          return self.localeDataSource.get(id: request)
            .map { self.mapper.transformEntityToDomain(entity: $0 ?? result) }
            .eraseToAnyPublisher()
        } else {
          return self.remoteDataSource.get(request: request)
            .first()
            .map { self.mapper.transformResponseToDomain(response: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
}
