//
//  LocaleDataSource.swift
//  Foodify
//
//  Created by Jamal on 31/12/20.
//  Copyright © 2020 Kementerian Agama RI. All rights reserved.
//

import Combine
import Foundation
import RealmSwift

protocol LocaleDataSourceProtocol: class {
  func getDetail(id: String) -> AnyPublisher<DetailEntity?, Error>
  func favorite(favorited: Bool, meal details: DetailEntity) -> AnyPublisher<Bool, Error>
  func getFavDetail() -> AnyPublisher<[DetailEntity], Error>
}

final class LocaleDataSource: NSObject {
  private let realm: Realm?
  private init(realm: Realm?) {
    self.realm = realm
  }

  static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
    LocaleDataSource(realm: realmDatabase)
  }
}

extension LocaleDataSource {
  func isFavorited(id: String) -> Bool {
    realm?.object(ofType: DetailEntity.self, forPrimaryKey: id) != nil
  }

  func addFavDetails(details: DetailEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            realm.add(details, update: .all)
            completion(.success(details.favorited))
          }
        } catch let error {
          completion(.failure(Error.localizedDescription(error.localizedDescription)))
        }
      } else {
        completion(.failure(Error.localizedDescription(self.realm.debugDescription)))
      }
    }.eraseToAnyPublisher()
  }

  func deleteFavDetails(details: DetailEntity) -> AnyPublisher<Bool, Error> {
    Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            guard let detailsToDelete = realm.object(
              ofType: DetailEntity.self,
              forPrimaryKey: details.id
            ) else { return }
            realm.delete(detailsToDelete)
            completion(.success(details.favorited))
          }
        } catch let error {
          completion(.failure(Error.localizedDescription(error.localizedDescription)))
        }
      } else {
        completion(.failure(Error.localizedDescription(self.realm.debugDescription)))
      }
    }.eraseToAnyPublisher()
  }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
  func getDetail(id: String) -> AnyPublisher<DetailEntity?, Error> {
    Future<DetailEntity?, Error> { completion in
      if let realm = self.realm {
        let details: DetailEntity? = {
          realm.object(ofType: DetailEntity.self, forPrimaryKey: id)
        }()
        completion(.success(details))
      } else {
        completion(.failure(Error.localizedDescription(self.realm.debugDescription)))
      }
    }.eraseToAnyPublisher()
  }

  func getFavDetail() -> AnyPublisher<[DetailEntity], Error> {
    var token: NotificationToken?
    let passThroughSubject = PassthroughSubject<[DetailEntity], Error>()
    if let realm = self.realm {
      let details: Results<DetailEntity> = {
        realm.objects(DetailEntity.self)
          .sorted(byKeyPath: "name", ascending: true)
      }()
      token = details.observe { changes in
        switch changes {
        case let .error(error):
          passThroughSubject
            .send(
              completion: .failure(Error.localizedDescription(error.localizedDescription))
            )
        default:
          passThroughSubject.send(details.toArray(ofType: DetailEntity.self))
        }
      }
    } else {
      passThroughSubject
        .send(
          completion: .failure(Error.localizedDescription(realm.debugDescription))
        )
    }
    return passThroughSubject
      .handleEvents(receiveCancel: { token?.invalidate()
      })
      .eraseToAnyPublisher()
  }

  func favorite(favorited: Bool, meal details: DetailEntity) -> AnyPublisher<Bool, Error> {
    details.favorited = !favorited
    if favorited {
      return deleteFavDetails(details: details)
    } else {
      return addFavDetails(details: details)
    }
  }
}
