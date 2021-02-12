//
//  MealsTransformer.swift
//  Foodify
//
//  Created by Jamal on 09/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import FoodifyCore

public struct MealsTransformer: Mapper {
  private let mealTransformer = MealTransformer()
  public typealias Response = [MealResponse]
  public typealias Entity = [MealEntity]
  public typealias Domain = [MealModel]

  public init() {}

  public func transformResponseToEntity(response: [MealResponse]?) -> [MealEntity] {
    guard let response = response else { return [] }
    return response.map { meal in
      mealTransformer.transformResponseToEntity(response: meal)
    }
  }

  public func transformEntityToDomain(entity: [MealEntity]?) -> [MealModel] {
    guard let entity = entity else { return [] }
    return entity.map { meal in mealTransformer.transformEntityToDomain(entity: meal)
    }
  }

  public func transformResponseToDomain(response: [MealResponse]?) -> [MealModel] {
    guard let response = response else { return [] }
    return response.map { meal in
      mealTransformer.transformResponseToDomain(response: meal)
    }
  }

  public func transformDomainToEntity(domain: [MealModel]?) -> [MealEntity] {
    guard let domain = domain else { return [] }
    return domain.map { meal in
      mealTransformer.transformDomainToEntity(domain: meal)
    }
  }
}
