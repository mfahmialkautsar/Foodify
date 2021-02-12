//
//  CategoryTransformer.swift
//  Foodify
//
//  Created by Jamal on 08/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import FoodifyCore

public struct CategoriesTransformer: Mapper {
  public typealias Response = [CategoryResponse]
  public typealias Entity = Any
  public typealias Domain = [CategoryModel]

  public init() {}

  public func transformResponseToEntity(response: [CategoryResponse]?) -> Any {
    return []
  }

  public func transformEntityToDomain(entity: Any?) -> [CategoryModel] {
    return []
  }

  public func transformResponseToDomain(response: [CategoryResponse]?) -> [CategoryModel] {
    guard let response = response else { return [] }
    return response.map { category in
      CategoryModel(
        id: category.id,
        name: category.name,
        image: category.image,
        desc: category.desc
      )
    }
  }

  public func transformDomainToEntity(domain: [CategoryModel]?) -> Any {
    return []
  }
}
