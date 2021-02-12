//
//  GetCategoriesRepository.swift
//  Foodify
//
//  Created by Jamal on 08/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Combine
import FoodifyCore

public struct GetCategoriesRepository<
  CategoryLocaleDataSource,
  CategoryRemoteDataSource: RemoteDataSource,
  Transformer: Mapper>: Repository
  where
  CategoryRemoteDataSource.Response == [CategoryResponse],
  Transformer.Response == CategoryRemoteDataSource.Response,
  Transformer.Domain == [CategoryModel] {
  public typealias Request = CategoryRemoteDataSource.Request
  public typealias Response = [CategoryModel]

  private let remoteDataSource: CategoryRemoteDataSource
  private let mapper: Transformer

  public init(
    remoteDataSource: CategoryRemoteDataSource,
    mapper: Transformer
  ) {
    self.remoteDataSource = remoteDataSource
    self.mapper = mapper
  }

  public func execute(request: CategoryRemoteDataSource.Request?) -> AnyPublisher<[CategoryModel], Error> {
    remoteDataSource.get(request: request)
      .map { self.mapper.transformResponseToDomain(response: $0) }
      .eraseToAnyPublisher()
  }
}
