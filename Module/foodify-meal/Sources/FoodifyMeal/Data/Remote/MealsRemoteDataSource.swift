//
//  MealsRemoteDataSource.swift
//
//
//  Created by Jamal on 06/02/21.
//

import Alamofire
import Combine
import FoodifyCore
import Foundation

public class MealsRemoteDataSource: RemoteDataSource {
  public typealias Request = String
  public typealias Response = [MealResponse]
  private var searchRequest: DataRequest?
  private let endpoint: (String) -> (String)

  public init(endpoint: @escaping (String) -> (String)) {
    self.endpoint = endpoint
  }

  public func get(request: String?) -> AnyPublisher<[MealResponse], Error> {
    searchRequest?.cancel()
    return Future<[MealResponse], Error> { completion in
      guard let request = request, !request.isEmpty else {
        completion(.success([]))
        return
      }
      if let url = URL(string: self.endpoint(request)) {
        self.searchRequest = AF.request(url).validate().responseDecodable(of: MealsResponse.self) { response in
          guard let searchRequest = self.searchRequest, !searchRequest.isCancelled else {
            return completion(.success([]))
          }
          switch response.result {
          case let .success(value):
            completion(.success(value.meals))
          case let .failure(error):
            completion(.failure(error))
          }
        }
      }
    }.eraseToAnyPublisher()
  }
}
