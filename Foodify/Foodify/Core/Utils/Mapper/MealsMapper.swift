//
//  MealsMapper.swift
//  Foodify
//
//  Created by Jamal on 09/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import FoodifyCore
import FoodifyMeal

final class MealsMapper: PresentationMapper {
  private let ingredientsMapper = IngredientsMapper()
  private let mealMapper = MealMapper()
  typealias Domain = [MealModel]?
  typealias Model = [Meal]

  func transformDomainToModel(domain: [MealModel]?) -> [Meal] {
    guard let domain = domain else { return [] }
    return domain.map { meal in
      mealMapper.transformDomainToModel(domain: meal)
    }
  }

  func transformModelToDomain(model: [Meal]) -> [MealModel]? {
    model.map { meal in
      mealMapper.transformModelToDomain(model: meal)
    }
  }
}
