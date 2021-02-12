//
//  IngredientsMapper.swift
//  Foodify
//
//  Created by Jamal on 09/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import FoodifyCore
import FoodifyMeal

final class IngredientsMapper: PresentationMapper {
  typealias Domain = [IngredientModel]
  typealias Model = [Ingredient]

  func transformDomainToModel(domain: [IngredientModel]) -> [Ingredient] {
    domain.map { ingredient in
      Ingredient(
        id: ingredient.id,
        name: ingredient.name,
        mealId: ingredient.mealId
      )
    }
  }

  func transformModelToDomain(model: [Ingredient]) -> [IngredientModel] {
    model.map { ingredient in
      IngredientModel(
        id: ingredient.id,
        name: ingredient.name,
        mealId: ingredient.mealId
      )
    }
  }
}
