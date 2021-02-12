//
//  APICall.swift
//  Foodify
//
//  Created by Jamal on 31/12/20.
//  Copyright © 2020 Kementerian Agama RI. All rights reserved.
//

import Foundation

struct API {
  static let baseUrl = "https://www.themealdb.com/api/json/v1/1/"
}

protocol Endpoint {
  var url: String { get }
}

enum Endpoints {
  enum Gets: Endpoint {
    case categories
    case byCategory(String)
    case byName(String)
    case byId(String)

    public var url: String {
      switch self {
      case .categories:
        return "\(API.baseUrl)categories.php"
      case let .byCategory(category):
        return "\(API.baseUrl)filter.php?c=\(category)"
      case let .byName(query):
        return "\(API.baseUrl)search.php?s=\(query)"
      case let .byId(id):
        return "\(API.baseUrl)lookup.php?i=\(id)"
      }
    }
  }
}
