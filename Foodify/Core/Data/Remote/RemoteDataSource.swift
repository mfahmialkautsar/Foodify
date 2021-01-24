//
//  RemoteDataSource.swift
//  Foodify
//
//  Created by Jamal on 31/12/20.
//  Copyright © 2020 Kementerian Agama RI. All rights reserved.
//

import Alamofire
import Combine
import Foundation

protocol RemoteDataSourceProtocol: class {
  func getCategories() -> AnyPublisher<[CategoryResponse], Error>
  func getMealsByCategory(category: String) -> AnyPublisher<[MealResponse], Error>
  func getDetail(id: String) -> AnyPublisher<[DetailResponse], Error>
  func getMealsByName(name: String) -> AnyPublisher<[DetailResponse]?, Error>
}

final class RemoteDataSource: NSObject {
  override private init() {}
  static let sharedInstance: RemoteDataSource = RemoteDataSource()
  private var searchRequest: DataRequest?
}

extension RemoteDataSource: RemoteDataSourceProtocol {
  func getCategories() -> AnyPublisher<[CategoryResponse], Error> {
    Future<[CategoryResponse], Error> { completion in
      if let url = URL(string: Endpoints.Gets.categories.url) {
        AF.request(url).validate().responseDecodable(of: CategoriesResponse.self) { response in
          switch response.result {
          case let .success(value):
            completion(.success(value.categories))
          case let .failure(error):
            completion(.failure(Error.localizedDescription(error.localizedDescription)))
          }
        }
      }
    }.eraseToAnyPublisher()
  }

  func getMealsByCategory(category: String) -> AnyPublisher<[MealResponse], Error> {
    Future<[MealResponse], Error> { completion in
      if let url = URL(string: Endpoints.Gets.byCategories(category).url) {
        AF.request(url).validate().responseDecodable(of: MealsResponse.self) { response in
          switch response.result {
          case let .success(value):
            completion(.success(value.meals))
          case let .failure(error):
            completion(.failure(Error.localizedDescription(error.localizedDescription)))
          }
        }
      }
    }.eraseToAnyPublisher()
  }

  func getDetail(id: String) -> AnyPublisher<[DetailResponse], Error> {
    Future<[DetailResponse], Error> { completion in
      if let url = URL(string: Endpoints.Gets.details(id).url) {
        AF.request(url).validate().responseDecodable(of: DetailsResponse.self) { response in
          switch response.result {
          case let .success(value):
            completion(.success(value.meals))
          case let .failure(error):
            completion(.failure(Error.localizedDescription(error.localizedDescription)))
          }
        }
      }
    }.eraseToAnyPublisher()
  }

  func getMealsByName(name: String) -> AnyPublisher<[DetailResponse]?, Error> {
    searchRequest?.cancel()
    return Future<[DetailResponse]?, Error> { completion in
      guard !name.isEmpty else {
        completion(.success(nil))
        return
      }
      if let url = URL(string: Endpoints.Gets.search(name).url) {
        self.searchRequest = AF.request(url).validate().responseDecodable(of: DetailsResponse.self) { response in
          guard let searchRequest = self.searchRequest, !searchRequest.isCancelled else { return }
          switch response.result {
          case let .success(value):
            completion(.success(value.meals))
          case let .failure(error):
            completion(.failure(Error.localizedDescription(error.localizedDescription)))
          }
        }
      }
    }.eraseToAnyPublisher()
  }
}
