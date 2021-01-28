//
//  PresentationMapper.swift
//  Foodify
//
//  Created by Jamal on 25/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Foundation

final class PresentationMapper {
  static func mapDetailPresentationToDomain(
    input detail: Detail
  ) -> DetailModel {
    DetailModel(
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

  static func mapDetailsPresentationToMealPresentation(
    input details: [Detail]?
  ) -> [Meal]? {
    guard let details = details else { return nil }
    return details.map { result in
      Meal(
        id: result.id,
        name: result.name,
        image: result.image
      )
    }
  }
}
