//
//  MealMapper.swift
//  Foodify
//
//  Created by Jamal on 09/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import FoodifyCore
import FoodifyMeal

final class MealMapper: PresentationMapper {
  private let ingredientsMapper = IngredientsMapper()
  typealias Domain = MealModel
  typealias Model = Meal

  func transformDomainToModel(domain: MealModel) -> Meal {
    let ingredients = ingredientsMapper.transformDomainToModel(domain: domain.ingredients)
    return Meal(
      id: domain.id,
      name: domain.name,
      category: domain.category,
      origin: domain.origin,
      instructions: domain.instructions,
      image: domain.image,
      tag: domain.tag,
      youtube: domain.youtube,
      source: domain.source,
      dateModified: domain.dateModified,
      ingredients: ingredients,
      favorited: domain.favorited
    )
  }

  func transformModelToDomain(model: Meal) -> MealModel {
    let ingredients = ingredientsMapper.transformModelToDomain(model: model.ingredients)
    return MealModel(
      id: model.id,
      name: model.name,
      category: model.category,
      origin: model.origin,
      instructions: model.instructions,
      image: model.image,
      tag: model.tag,
      youtube: model.youtube,
      source: model.source,
      dateModified: model.dateModified,
      ingredients: ingredients,
      favorited: model.favorited
    )
  }
}
