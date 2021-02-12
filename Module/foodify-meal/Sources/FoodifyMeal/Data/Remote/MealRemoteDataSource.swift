//
//  MealRemoteDataSource.swift
//  Foodify
//
//  Created by Jamal on 07/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Alamofire
import Combine
import FoodifyCore
import Foundation

public class MealRemoteDataSource: RemoteDataSource {
  public typealias Request = String
  public typealias Response = MealResponse
  private let endpoint: (String) -> (String)

  public init(endpoint: @escaping (String) -> (String)) {
    self.endpoint = endpoint
  }

  public func get(request: String?) -> AnyPublisher<MealResponse, Error> {
    return Future<MealResponse, Error> { completion in
      guard let request = request else { fatalError() }
      if let url = URL(string: self.endpoint(request)) {
        AF.request(url).validate().responseDecodable(of: MealsResponse.self) { response in
          switch response.result {
          case let .success(value):
            completion(.success(value.meals[0]))
          case let .failure(error):
            completion(.failure(error))
          }
        }
      }
    }.eraseToAnyPublisher()
  }
}
