//
//  MealLocaleDataSource.swift
//
//
//  Created by Jamal on 06/02/21.
//

import Combine
import FoodifyCore
import Foundation
import RealmSwift

public class MealLocaleDataSource: LocaleDataSource {
  public typealias Request = Any
  public typealias Response = MealEntity

  private let realm: Realm

  public init(realm: Realm) {
    self.realm = realm
  }

  public func list(request: Any?) -> AnyPublisher<[MealEntity], Error> {
    var token: NotificationToken?
    let passThroughSubject = PassthroughSubject<[MealEntity], Error>()
    let details: Results<MealEntity> = {
      realm.objects(MealEntity.self)
        .sorted(byKeyPath: "name", ascending: true)
    }()
    token = details.observe { changes in
      switch changes {
      case let .error(error):
        passThroughSubject
          .send(
            completion: .failure(error)
          )
      default:
        passThroughSubject.send(details.toArray(ofType: MealEntity.self))
      }
    }
    return passThroughSubject
      .handleEvents(receiveCancel: { token?.invalidate()
      })
      .eraseToAnyPublisher()
  }

  public func add(entities: MealEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        try self.realm.write {
          self.realm.add(entities, update: .all)
          completion(.success(entities.favorited))
        }
      } catch let error {
        completion(.failure(error))
      }
    }.eraseToAnyPublisher()
  }

  public func get(id: String) -> AnyPublisher<MealEntity?, Error> {
    Future<MealEntity?, Error> { completion in
      let details: MealEntity? = {
        self.realm.object(ofType: MealEntity.self, forPrimaryKey: id)
      }()
      completion(.success(details))
    }.eraseToAnyPublisher()
  }

  public func update(entity: MealEntity) -> AnyPublisher<Bool, Error> {
    entity.favorited = !entity.favorited
    if entity.favorited {
      return add(entities: entity)
    } else {
      return delete(id: entity.id)
    }
  }

  public func delete(id: String) -> AnyPublisher<Bool, Error> {
    Future<Bool, Error> { completion in
      do {
        try self.realm.write {
          guard let detailsToDelete = self.realm.object(
            ofType: MealEntity.self,
            forPrimaryKey: id
          ) else { return }
          self.realm.delete(detailsToDelete)
          completion(.success(false))
        }
      } catch let error {
        completion(.failure(error))
      }
    }.eraseToAnyPublisher()
  }
}
