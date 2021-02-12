//
//  CategoryMapper.swift
//  Foodify
//
//  Created by Jamal on 08/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import FoodifyCategory
import FoodifyCore

final class CategoriesMapper: PresentationMapper {
  typealias Domain = [CategoryModel]
  typealias Model = [Category]

  func transformDomainToModel(domain: [CategoryModel]) -> [Category] {
    domain.map { category in
      Category(
        id: category.id,
        name: category.name,
        image: category.image,
        desc: category.desc
      )
    }
  }

  func transformModelToDomain(model: [Category]) -> [CategoryModel] {
    model.map { model in
      CategoryModel(
        id: model.id,
        name: model.name,
        image: model.image,
        desc: model.desc
      )
    }
  }
}
