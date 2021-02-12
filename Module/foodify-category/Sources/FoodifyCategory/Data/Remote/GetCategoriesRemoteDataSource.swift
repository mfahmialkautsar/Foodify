//
//  GetCategoriesRemoteDataSource.swift
//  Foodify
//
//  Created by Jamal on 07/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Alamofire
import Combine
import FoodifyCore
import Foundation

public struct GetCategoriesRemoteDataSource: RemoteDataSource {
  public typealias Request = String
  public typealias Response = [CategoryResponse]
  private let endpoint: (String) -> (String)

  public init(endpoint: @escaping (String) -> (String)) {
    self.endpoint = endpoint
  }

  public func get(request: String?) -> AnyPublisher<[CategoryResponse], Error> {
    Future<[CategoryResponse], Error> { completion in
      if let url = URL(string: self.endpoint(request ?? "")) {
        AF.request(url).validate().responseDecodable(of: CategoriesResponse.self) { response in
          switch response.result {
          case let .success(value):
            completion(.success(value.categories))
          case let .failure(error):
            completion(.failure(error))
          }
        }
      }
    }.eraseToAnyPublisher()
  }
}
