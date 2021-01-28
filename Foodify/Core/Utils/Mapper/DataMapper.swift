//
//  DataMapper.swift
//  Foodify
//
//  Created by Jamal on 31/12/20.
//  Copyright © 2020 Kementerian Agama RI. All rights reserved.
//

import Foundation

final class DataMapper {
  static func mapCategoriesResponseToDomain(
    input categories: [CategoryResponse]
  ) -> [CategoryModel] {
    return categories.map { result in
      CategoryModel(
        id: result.id,
        name: result.name,
        image: result.image,
        desc: result.desc
      )
    }
  }

  static func mapMealsResponseToDomain(
    input meals: [MealResponse]
  ) -> [MealModel] {
    return meals.map { result in
      MealModel(
        id: result.id,
        name: result.name,
        image: result.image
      )
    }
  }

  static func mapDetailsResponseToDomain(
    input details: [DetailResponse]
  ) -> [DetailModel] {
    let results = details.map { result in
      DetailModel(
        id: result.id,
        name: result.name,
        category: result.category,
        origin: result.origin,
        instructions: result.instructions,
        image: result.image,
        tag: result.tag,
        youtube: result.youtube,
        ingredient1: result.ingredient1,
        ingredient2: result.ingredient2,
        ingredient3: result.ingredient3,
        ingredient4: result.ingredient4,
        ingredient5: result.ingredient5,
        ingredient6: result.ingredient6,
        ingredient7: result.ingredient7,
        ingredient8: result.ingredient8,
        ingredient9: result.ingredient9,
        ingredient10: result.ingredient10,
        ingredient11: result.ingredient11,
        ingredient12: result.ingredient12,
        ingredient13: result.ingredient13,
        ingredient14: result.ingredient14,
        ingredient15: result.ingredient15,
        ingredient16: result.ingredient16,
        ingredient17: result.ingredient17,
        ingredient18: result.ingredient18,
        ingredient19: result.ingredient19,
        ingredient20: result.ingredient20,
        measure1: result.measure1,
        measure2: result.measure2,
        measure3: result.measure3,
        measure4: result.measure4,
        measure5: result.measure5,
        measure6: result.measure6,
        measure7: result.measure7,
        measure8: result.measure8,
        measure9: result.measure9,
        measure10: result.measure10,
        measure11: result.measure11,
        measure12: result.measure12,
        measure13: result.measure13,
        measure14: result.measure14,
        measure15: result.measure15,
        measure16: result.measure16,
        measure17: result.measure17,
        measure18: result.measure18,
        measure19: result.measure19,
        measure20: result.measure20,
        source: result.source,
        dateModified: result.dateModified
      )
    }
    return results
  }

  static func mapDetailsResponseToDomain(
    input details: [DetailResponse]?
  ) -> [DetailModel]? {
    guard let details = details else { return nil }
    return details.map { result in
      DetailModel(
        id: result.id,
        name: result.name,
        category: result.category,
        origin: result.origin,
        instructions: result.instructions,
        image: result.image,
        tag: result.tag,
        youtube: result.youtube,
        ingredient1: result.ingredient1,
        ingredient2: result.ingredient2,
        ingredient3: result.ingredient3,
        ingredient4: result.ingredient4,
        ingredient5: result.ingredient5,
        ingredient6: result.ingredient6,
        ingredient7: result.ingredient7,
        ingredient8: result.ingredient8,
        ingredient9: result.ingredient9,
        ingredient10: result.ingredient10,
        ingredient11: result.ingredient11,
        ingredient12: result.ingredient12,
        ingredient13: result.ingredient13,
        ingredient14: result.ingredient14,
        ingredient15: result.ingredient15,
        ingredient16: result.ingredient16,
        ingredient17: result.ingredient17,
        ingredient18: result.ingredient18,
        ingredient19: result.ingredient19,
        ingredient20: result.ingredient20,
        measure1: result.measure1,
        measure2: result.measure2,
        measure3: result.measure3,
        measure4: result.measure4,
        measure5: result.measure5,
        measure6: result.measure6,
        measure7: result.measure7,
        measure8: result.measure8,
        measure9: result.measure9,
        measure10: result.measure10,
        measure11: result.measure11,
        measure12: result.measure12,
        measure13: result.measure13,
        measure14: result.measure14,
        measure15: result.measure15,
        measure16: result.measure16,
        measure17: result.measure17,
        measure18: result.measure18,
        measure19: result.measure19,
        measure20: result.measure20,
        source: result.source,
        dateModified: result.dateModified
      )
    }
  }

  static func mapDetailEntityToDomain(
    input detail: DetailEntity
  ) -> DetailModel {
    return DetailModel(
      id: detail.id,
      name: detail.name,
      category: detail.category,
      origin: detail.origin,
      instructions: detail.instructions,
      image: detail.image,
      tag: detail.tag,
      youtube: detail.youtube,
      ingredient1: detail.ingredient1,
      ingredient2: detail.ingredient2,
      ingredient3: detail.ingredient3,
      ingredient4: detail.ingredient4,
      ingredient5: detail.ingredient5,
      ingredient6: detail.ingredient6,
      ingredient7: detail.ingredient7,
      ingredient8: detail.ingredient8,
      ingredient9: detail.ingredient9,
      ingredient10: detail.ingredient10,
      ingredient11: detail.ingredient11,
      ingredient12: detail.ingredient12,
      ingredient13: detail.ingredient13,
      ingredient14: detail.ingredient14,
      ingredient15: detail.ingredient15,
      ingredient16: detail.ingredient16,
      ingredient17: detail.ingredient17,
      ingredient18: detail.ingredient18,
      ingredient19: detail.ingredient19,
      ingredient20: detail.ingredient20,
      measure1: detail.measure1,
      measure2: detail.measure2,
      measure3: detail.measure3,
      measure4: detail.measure4,
      measure5: detail.measure5,
      measure6: detail.measure6,
      measure7: detail.measure7,
      measure8: detail.measure8,
      measure9: detail.measure9,
      measure10: detail.measure10,
      measure11: detail.measure11,
      measure12: detail.measure12,
      measure13: detail.measure13,
      measure14: detail.measure14,
      measure15: detail.measure15,
      measure16: detail.measure16,
      measure17: detail.measure17,
      measure18: detail.measure18,
      measure19: detail.measure19,
      measure20: detail.measure20,
      source: detail.source,
      dateModified: detail.dateModified,
      favorited: detail.favorited
    )
  }

  static func mapDetailsEntityToMealDomain(
    input details: [DetailEntity]
  ) -> [MealModel] {
    return details.map { result in
      MealModel(
        id: result.id,
        name: result.name,
        image: result.image
      )
    }
  }
}
