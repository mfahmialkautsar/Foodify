//
//  DataRepository.swift
//  Foodify
//
//  Created by Jamal on 31/12/20.
//  Copyright © 2020 Kementerian Agama RI. All rights reserved.
//

import Combine
import Foundation

protocol DataRepositoryProtocol {
  func getCategories() -> AnyPublisher<[CategoryModel], Error>
  func getMealsByCategory(category: String) -> AnyPublisher<[MealModel], Error>
  func getDetail(id: String) -> AnyPublisher<DetailModel, Error>
  func getFavorteMeals() -> AnyPublisher<[MealModel], Error>
  func favorite(details: DetailModel) -> AnyPublisher<Bool, Error>
  func getMealsByName(name: String) -> AnyPublisher<[DetailModel]?, Error>
}

final class DataRepository: NSObject {
  typealias DataInstance = (LocaleDataSource, RemoteDataSource) -> DataRepository

  fileprivate let locale: LocaleDataSource
  fileprivate let remote: RemoteDataSource

  private init(locale: LocaleDataSource, remote: RemoteDataSource) {
    self.locale = locale
    self.remote = remote
  }

  static let sharedInstance: DataInstance = { localeRepository, remoteRepository in
    DataRepository(locale: localeRepository, remote: remoteRepository)
  }
}

extension DataRepository: DataRepositoryProtocol {
  func getCategories() -> AnyPublisher<[CategoryModel], Error> {
    remote.getCategories()
      .map { ModelMapper.mapCategoryResponseToDomain(input: $0) }
      .eraseToAnyPublisher()
  }

  func getMealsByCategory(category: String) -> AnyPublisher<[MealModel], Error> {
    remote.getMealsByCategory(category: category)
      .map { ModelMapper.mapMealResponseToDomain(input: $0) }
      .eraseToAnyPublisher()
  }

  func getDetail(id: String) -> AnyPublisher<DetailModel, Error> {
    locale.getDetail(id: id)
      .flatMap { result -> AnyPublisher<DetailModel, Error> in
        if let result = result {
          return self.locale.getDetail(id: id)
            .map { ModelMapper.mapDetailsEntityToDomain(input: $0 ?? result) }
            .eraseToAnyPublisher()
        } else {
          return self.remote.getDetail(id: id)
            .map { ModelMapper.mapDetailsResponseToDomain(input: $0)[0] }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }

  func getFavorteMeals() -> AnyPublisher<[MealModel], Error> {
    locale.getFavDetail()
      .map { ModelMapper.mapDetailsEntityToMealDomain(input: $0) }
      .eraseToAnyPublisher()
  }

  func favorite(details: DetailModel) -> AnyPublisher<Bool, Error> {
    locale.favorite(favorited: details.favorited, meal: ModelMapper.mapDetailsDomainToEntity(input: details))
  }

  func getMealsByName(name: String) -> AnyPublisher<[DetailModel]?, Error> {
    remote.getMealsByName(name: name)
      .map { ModelMapper.mapDetailsResponseToDomain(input: $0) }
      .eraseToAnyPublisher()
  }
}
