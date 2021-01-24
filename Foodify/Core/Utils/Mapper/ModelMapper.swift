//
//  ModelMapper.swift
//  Foodify
//
//  Created by Jamal on 31/12/20.
//  Copyright © 2020 Kementerian Agama RI. All rights reserved.
//

import Foundation

final class ModelMapper {
  static func mapCategoryResponseToDomain(
    input category: [CategoryResponse]
  ) -> [CategoryModel] {
    return category.map { result in
      CategoryModel(
        id: result.id,
        name: result.name,
        image: result.image,
        desc: result.desc
      )
    }
  }

  static func mapMealResponseToDomain(
    input meal: [MealResponse]
  ) -> [MealModel] {
    return meal.map { result in
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

  static func mapDetailsEntityToDomain(
    input details: DetailEntity
  ) -> DetailModel {
    return DetailModel(
      id: details.id,
      name: details.name,
      category: details.category,
      origin: details.origin,
      instructions: details.instructions,
      image: details.image,
      tag: details.tag,
      youtube: details.youtube,
      ingredient1: details.ingredient1,
      ingredient2: details.ingredient2,
      ingredient3: details.ingredient3,
      ingredient4: details.ingredient4,
      ingredient5: details.ingredient5,
      ingredient6: details.ingredient6,
      ingredient7: details.ingredient7,
      ingredient8: details.ingredient8,
      ingredient9: details.ingredient9,
      ingredient10: details.ingredient10,
      ingredient11: details.ingredient11,
      ingredient12: details.ingredient12,
      ingredient13: details.ingredient13,
      ingredient14: details.ingredient14,
      ingredient15: details.ingredient15,
      ingredient16: details.ingredient16,
      ingredient17: details.ingredient17,
      ingredient18: details.ingredient18,
      ingredient19: details.ingredient19,
      ingredient20: details.ingredient20,
      measure1: details.measure1,
      measure2: details.measure2,
      measure3: details.measure3,
      measure4: details.measure4,
      measure5: details.measure5,
      measure6: details.measure6,
      measure7: details.measure7,
      measure8: details.measure8,
      measure9: details.measure9,
      measure10: details.measure10,
      measure11: details.measure11,
      measure12: details.measure12,
      measure13: details.measure13,
      measure14: details.measure14,
      measure15: details.measure15,
      measure16: details.measure16,
      measure17: details.measure17,
      measure18: details.measure18,
      measure19: details.measure19,
      measure20: details.measure20,
      source: details.source,
      dateModified: details.dateModified,
      favorited: details.favorited
    )
  }

  static func mapDetailsDomainToEntity(
    input details: DetailModel
  ) -> DetailEntity {
    let detailsEntity = DetailEntity()
    detailsEntity.id = details.id ?? ""
    detailsEntity.name = details.name ?? ""
    detailsEntity.category = details.category ?? ""
    detailsEntity.origin = details.origin ?? ""
    detailsEntity.instructions = details.instructions ?? ""
    detailsEntity.image = details.image ?? ""
    detailsEntity.tag = details.tag ?? ""
    detailsEntity.youtube = details.youtube ?? ""
    detailsEntity.ingredient1 = details.ingredient1 ?? ""
    detailsEntity.ingredient2 = details.ingredient2 ?? ""
    detailsEntity.ingredient3 = details.ingredient3 ?? ""
    detailsEntity.ingredient4 = details.ingredient4 ?? ""
    detailsEntity.ingredient5 = details.ingredient5 ?? ""
    detailsEntity.ingredient6 = details.ingredient6 ?? ""
    detailsEntity.ingredient7 = details.ingredient7 ?? ""
    detailsEntity.ingredient8 = details.ingredient8 ?? ""
    detailsEntity.ingredient9 = details.ingredient9 ?? ""
    detailsEntity.ingredient10 = details.ingredient10 ?? ""
    detailsEntity.ingredient11 = details.ingredient11 ?? ""
    detailsEntity.ingredient12 = details.ingredient12 ?? ""
    detailsEntity.ingredient13 = details.ingredient13 ?? ""
    detailsEntity.ingredient14 = details.ingredient14 ?? ""
    detailsEntity.ingredient15 = details.ingredient15 ?? ""
    detailsEntity.ingredient16 = details.ingredient16 ?? ""
    detailsEntity.ingredient17 = details.ingredient17 ?? ""
    detailsEntity.ingredient18 = details.ingredient18 ?? ""
    detailsEntity.ingredient19 = details.ingredient19 ?? ""
    detailsEntity.ingredient20 = details.ingredient20 ?? ""
    detailsEntity.measure1 = details.measure1 ?? ""
    detailsEntity.measure2 = details.measure2 ?? ""
    detailsEntity.measure3 = details.measure3 ?? ""
    detailsEntity.measure4 = details.measure4 ?? ""
    detailsEntity.measure5 = details.measure5 ?? ""
    detailsEntity.measure6 = details.measure6 ?? ""
    detailsEntity.measure7 = details.measure7 ?? ""
    detailsEntity.measure8 = details.measure8 ?? ""
    detailsEntity.measure9 = details.measure9 ?? ""
    detailsEntity.measure10 = details.measure10 ?? ""
    detailsEntity.measure11 = details.measure11 ?? ""
    detailsEntity.measure12 = details.measure12 ?? ""
    detailsEntity.measure13 = details.measure13 ?? ""
    detailsEntity.measure14 = details.measure14 ?? ""
    detailsEntity.measure15 = details.measure15 ?? ""
    detailsEntity.measure16 = details.measure16 ?? ""
    detailsEntity.measure17 = details.measure17 ?? ""
    detailsEntity.measure18 = details.measure18 ?? ""
    detailsEntity.measure19 = details.measure19 ?? ""
    detailsEntity.measure20 = details.measure20 ?? ""
    detailsEntity.source = details.source ?? ""
    detailsEntity.dateModified = details.dateModified ?? ""
    return detailsEntity
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

  static func mapDetailDomainToMealDomain(
    input detail: DetailModel
  ) -> MealModel {
    return MealModel(
      id: detail.id,
      name: detail.name,
      image: detail.image
    )
  }
}
