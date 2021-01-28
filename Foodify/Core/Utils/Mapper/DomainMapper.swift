//
//  DomainMapper.swift
//  Foodify
//
//  Created by Jamal on 25/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Foundation

final class DomainMapper {
  static func mapCategoriesDomainToPresentation(
    input categories: [CategoryModel]
  ) -> [Category] {
    categories.map { result in
      Category(
        id: result.id,
        name: result.name,
        image: result.image,
        desc: result.desc
      )
    }
  }

  static func mapCategoryDomainToPresentation(
    input category: CategoryModel
  ) -> Category {
    return Category(
      id: category.id,
      name: category.name,
      image: category.image,
      desc: category.desc
    )
  }

  static func mapMealsDomainToPresentation(
    input meals: [MealModel]
  ) -> [Meal] {
    meals.map { result in
      Meal(
        id: result.id,
        name: result.name,
        image: result.image
      )
    }
  }

  static func mapMealDomainToPresentation(
    input meal: MealModel
  ) -> Meal {
    return Meal(
      id: meal.id,
      name: meal.name,
      image: meal.image
    )
  }

  static func mapDetailsDomainToPresenter(
    input details: [DetailModel]?
  ) -> [Detail]? {
    guard let details = details else { return nil }
    return details.map { result in
      Detail(
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
        dateModified: result.dateModified,
        favorited: result.favorited
      )
    }
  }

  static func mapDetailDomainToPresentation(
    input detail: DetailModel
  ) -> Detail {
    return Detail(
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

  static func mapDetailDomainToEntity(
    input detail: DetailModel
  ) -> DetailEntity {
    let detailEntity = DetailEntity()
    detailEntity.id = detail.id ?? ""
    detailEntity.name = detail.name ?? ""
    detailEntity.category = detail.category ?? ""
    detailEntity.origin = detail.origin ?? ""
    detailEntity.instructions = detail.instructions ?? ""
    detailEntity.image = detail.image ?? ""
    detailEntity.tag = detail.tag ?? ""
    detailEntity.youtube = detail.youtube ?? ""
    detailEntity.ingredient1 = detail.ingredient1 ?? ""
    detailEntity.ingredient2 = detail.ingredient2 ?? ""
    detailEntity.ingredient3 = detail.ingredient3 ?? ""
    detailEntity.ingredient4 = detail.ingredient4 ?? ""
    detailEntity.ingredient5 = detail.ingredient5 ?? ""
    detailEntity.ingredient6 = detail.ingredient6 ?? ""
    detailEntity.ingredient7 = detail.ingredient7 ?? ""
    detailEntity.ingredient8 = detail.ingredient8 ?? ""
    detailEntity.ingredient9 = detail.ingredient9 ?? ""
    detailEntity.ingredient10 = detail.ingredient10 ?? ""
    detailEntity.ingredient11 = detail.ingredient11 ?? ""
    detailEntity.ingredient12 = detail.ingredient12 ?? ""
    detailEntity.ingredient13 = detail.ingredient13 ?? ""
    detailEntity.ingredient14 = detail.ingredient14 ?? ""
    detailEntity.ingredient15 = detail.ingredient15 ?? ""
    detailEntity.ingredient16 = detail.ingredient16 ?? ""
    detailEntity.ingredient17 = detail.ingredient17 ?? ""
    detailEntity.ingredient18 = detail.ingredient18 ?? ""
    detailEntity.ingredient19 = detail.ingredient19 ?? ""
    detailEntity.ingredient20 = detail.ingredient20 ?? ""
    detailEntity.measure1 = detail.measure1 ?? ""
    detailEntity.measure2 = detail.measure2 ?? ""
    detailEntity.measure3 = detail.measure3 ?? ""
    detailEntity.measure4 = detail.measure4 ?? ""
    detailEntity.measure5 = detail.measure5 ?? ""
    detailEntity.measure6 = detail.measure6 ?? ""
    detailEntity.measure7 = detail.measure7 ?? ""
    detailEntity.measure8 = detail.measure8 ?? ""
    detailEntity.measure9 = detail.measure9 ?? ""
    detailEntity.measure10 = detail.measure10 ?? ""
    detailEntity.measure11 = detail.measure11 ?? ""
    detailEntity.measure12 = detail.measure12 ?? ""
    detailEntity.measure13 = detail.measure13 ?? ""
    detailEntity.measure14 = detail.measure14 ?? ""
    detailEntity.measure15 = detail.measure15 ?? ""
    detailEntity.measure16 = detail.measure16 ?? ""
    detailEntity.measure17 = detail.measure17 ?? ""
    detailEntity.measure18 = detail.measure18 ?? ""
    detailEntity.measure19 = detail.measure19 ?? ""
    detailEntity.measure20 = detail.measure20 ?? ""
    detailEntity.source = detail.source ?? ""
    detailEntity.dateModified = detail.dateModified ?? ""
    return detailEntity
  }

//  static func mapDetailDomainToMealDomain(
//    input detail: DetailModel
//  ) -> MealModel {
//    return MealModel(
//      id: detail.id,
//      name: detail.name,
//      image: detail.image
//    )
//  }
}
