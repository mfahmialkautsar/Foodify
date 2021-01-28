//
//  DataRepository.swift
//  Foodify
//
//  Created by Jamal on 31/12/20.
//  Copyright © 2020 Kementerian Agama RI. All rights reserved.
//

import Combine
import Foundation

protocol MealDataRepositoryProtocol {
  func getMealsByCategory(category: String) -> AnyPublisher<[MealModel], Error>
  func getMealsByName(name: String) -> AnyPublisher<[DetailModel]?, Error>
  func getFavorteMeals() -> AnyPublisher<[MealModel], Error>
}

protocol CategoryDataRepositoryProtocol {
  func getCategories() -> AnyPublisher<[CategoryModel], Error>
}

protocol DetailDataRepositoryProtocol {
  func getDetail(id: String) -> AnyPublisher<DetailModel, Error>
}

protocol FavoriteDataRepositoryProtocol {
  func favorite(detail: DetailModel) -> AnyPublisher<Bool, Error>
}

protocol DataRepositoryProtocol: CategoryDataRepositoryProtocol,
  MealDataRepositoryProtocol,
  DetailDataRepositoryProtocol,
  FavoriteDataRepositoryProtocol {}

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
      .map { DataMapper.mapCategoriesResponseToDomain(input: $0) }
      .eraseToAnyPublisher()
  }

  func getMealsByCategory(category: String) -> AnyPublisher<[MealModel], Error> {
    remote.getMealsByCategory(category: category)
      .map { DataMapper.mapMealsResponseToDomain(input: $0) }
      .eraseToAnyPublisher()
  }

  func getDetail(id: String) -> AnyPublisher<DetailModel, Error> {
    locale.getDetail(id: id)
      .flatMap { result -> AnyPublisher<DetailModel, Error> in
        if let result = result {
          return self.locale.getDetail(id: id)
            .map { DataMapper.mapDetailEntityToDomain(input: $0 ?? result) }
            .eraseToAnyPublisher()
        } else {
          return self.remote.getDetail(id: id)
            .map { DataMapper.mapDetailsResponseToDomain(input: $0)[0] }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }

  func getFavorteMeals() -> AnyPublisher<[MealModel], Error> {
    locale.getFavDetails()
      .map { DataMapper.mapDetailsEntityToMealDomain(input: $0) }
      .eraseToAnyPublisher()
  }

  func favorite(detail: DetailModel) -> AnyPublisher<Bool, Error> {
    locale.favorite(favorited: detail.favorited, meal: DomainMapper.mapDetailDomainToEntity(input: detail))
  }

  func getMealsByName(name: String) -> AnyPublisher<[DetailModel]?, Error> {
    remote.getMealsByName(name: name)
      .map { DataMapper.mapDetailsResponseToDomain(input: $0) }
      .eraseToAnyPublisher()
  }
}
