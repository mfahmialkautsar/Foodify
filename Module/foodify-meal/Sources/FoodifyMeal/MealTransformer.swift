//
//  MealTransformer.swift
//
//
//  Created by Jamal on 06/02/21.
//

import FoodifyCore

public struct MealTransformer: Mapper {
  private let ingredientTransformer = IngredientsTransformer()
  public typealias Response = MealResponse
  public typealias Entity = MealEntity
  public typealias Domain = MealModel

  public init() {}

  public func transformResponseToEntity(response: MealResponse?) -> MealEntity {
    guard let response = response else { return MealEntity() }
    let ingredients = ingredientTransformer.transformResponseToEntity(response: response)
    let meal = MealEntity()
    meal.id = response.id ?? ""
    meal.name = response.name ?? "Unkonwn"
    meal.category = response.category ?? "Unknown"
    meal.origin = response.origin ?? "Unknown"
    meal.instructions = response.instructions ?? "Unknown"
    meal.image = response.image ?? "Unknown"
    meal.tag = response.tag ?? "Unkown"
    meal.youtube = response.youtube ?? "Unknown"
    meal.source = response.source ?? "Unknown"
    meal.dateModified = response.dateModified ?? "Unknown"
    meal.ingredients = ingredients
    return meal
  }

  public func transformEntityToDomain(entity: MealEntity?) -> MealModel {
    guard let entity = entity else { fatalError() }
    let ingredients = ingredientTransformer.transformEntityToDomain(entity: entity.ingredients)
    return MealModel(
      id: entity.id,
      name: entity.name,
      category: entity.category,
      origin: entity.origin,
      instructions: entity.instructions,
      image: entity.image,
      tag: entity.image,
      youtube: entity.youtube,
      source: entity.source,
      dateModified: entity.dateModified,
      ingredients: ingredients,
      favorited: entity.favorited
    )
  }

  public func transformResponseToDomain(response: MealResponse?) -> MealModel {
    guard let response = response else { fatalError() }
    let ingredients = ingredientTransformer.transformResponseToDomain(response: response)
    return MealModel(
      id: response.id,
      name: response.name,
      category: response.category,
      origin: response.origin,
      instructions: response.instructions,
      image: response.image,
      tag: response.image,
      youtube: response.youtube,
      source: response.source,
      dateModified: response.dateModified,
      ingredients: ingredients,
      favorited: false
    )
  }

  public func transformDomainToEntity(domain: MealModel?) -> MealEntity {
    guard let domain = domain else { fatalError() }
    let ingredients = ingredientTransformer.transformDomainToEntity(domain: domain.ingredients)
    let meal = MealEntity()
    meal.id = domain.id ?? ""
    meal.name = domain.name ?? "Unkonwn"
    meal.category = domain.category ?? "Unknown"
    meal.origin = domain.origin ?? "Unknown"
    meal.instructions = domain.instructions ?? "Unknown"
    meal.image = domain.image ?? "Unknown"
    meal.tag = domain.tag ?? "Unkown"
    meal.youtube = domain.youtube ?? "Unknown"
    meal.source = domain.source ?? "Unknown"
    meal.dateModified = domain.dateModified ?? "Unknown"
    meal.ingredients = ingredients
    meal.favorited = domain.favorited
    return meal
  }
}
