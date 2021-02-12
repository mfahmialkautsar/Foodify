//
//  IngredientTransformer.swift
//  Foodify
//
//  Created by Jamal on 07/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import FoodifyCore
import Foundation
import RealmSwift

struct IngredientsTransformer: Mapper {
  typealias Response = MealResponse
  typealias Entity = List<IngredientEntity>
  typealias Domain = [IngredientModel]

  func transformResponseToEntity(response: MealResponse?) -> List<IngredientEntity> {
    guard let response = response else { return List<IngredientEntity>() }
    let ingredientEntities = List<IngredientEntity>()
    let finalIngredients = getIngredients(response: response)

    for (index, ingredient) in finalIngredients.enumerated() {
      let ingredientEntity = IngredientEntity()
      ingredientEntity.id = "\(index + 1)"
      ingredientEntity.name = "• \(ingredient)"
      ingredientEntity.mealId = response.id ?? ""
      ingredientEntities.append(ingredientEntity)
    }

    return ingredientEntities
  }

  func transformEntityToDomain(entity: List<IngredientEntity>?) -> [IngredientModel] {
    guard let entity = entity else { return [] }
    return entity.map { ingredient in
      IngredientModel(
        id: ingredient.id,
        name: ingredient.name,
        mealId: ingredient.mealId
      )
    }
  }

  func transformResponseToDomain(response: MealResponse?) -> [IngredientModel] {
    guard let response = response else { return [] }
    var ingredientModels = [IngredientModel]()
    let finalIngredients = getIngredients(response: response)

    for (index, ingredient) in finalIngredients.enumerated() {
      let ingredientModel = IngredientModel(
        id: "\(index + 1)",
        name: "• \(ingredient)",
        mealId: response.id ?? ""
      )
      ingredientModels.append(ingredientModel)
    }

    return ingredientModels
  }

  func transformDomainToEntity(domain: [IngredientModel]?) -> List<IngredientEntity> {
    guard let domain = domain else { return List<IngredientEntity>() }
    let ingredients = List<IngredientEntity>()
    for ingredient in domain {
      let entity = IngredientEntity()
      entity.id = ingredient.id
      entity.name = ingredient.name
      entity.mealId = ingredient.mealId
      ingredients.append(entity)
    }
    return ingredients
  }
}

fileprivate extension IngredientsTransformer {
  private func getIngredients(response: MealResponse) -> [String] {
    let ingredients = [
      response.ingredient1,
      response.ingredient2,
      response.ingredient3,
      response.ingredient4,
      response.ingredient5,
      response.ingredient6,
      response.ingredient7,
      response.ingredient8,
      response.ingredient9,
      response.ingredient10,
      response.ingredient11,
      response.ingredient12,
      response.ingredient13,
      response.ingredient14,
      response.ingredient15,
      response.ingredient16,
      response.ingredient17,
      response.ingredient18,
      response.ingredient19,
      response.ingredient20,
    ]
    .compactMap { $0 }
    .filter({ $0 != "" })

    let measures = [
      response.measure1,
      response.measure2,
      response.measure3,
      response.measure4,
      response.measure5,
      response.measure6,
      response.measure7,
      response.measure8,
      response.measure9,
      response.measure10,
      response.measure11,
      response.measure12,
      response.measure13,
      response.measure14,
      response.measure15,
      response.measure16,
      response.measure17,
      response.measure18,
      response.measure19,
      response.measure20,
    ]
    .compactMap { $0 }
    .filter({ $0 != "" })

    return zip(measures, ingredients)
      .map { "\($0) \($1)" }
  }
}
