//
//  DetailModel.swift
//  Foodify
//
//  Created by Jamal on 01/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Foundation

public struct MealsModel {
  public let detail: [MealModel]
}

public struct MealModel {
  public let id: String?
  public let name: String?
  public let category: String?
  public let origin: String?
  public let instructions: String?
  public let image: String?
  public let tag: String?
  public let youtube: String?
  public let source: String?
  public let dateModified: String?
  public let ingredients: [IngredientModel]
  public var favorited: Bool = false

  public init(
    id: String?,
    name: String?,
    category: String?,
    origin: String?,
    instructions: String?,
    image: String?,
    tag: String?,
    youtube: String?,
    source: String?,
    dateModified: String?,
    ingredients: [IngredientModel],
    favorited: Bool
  ) {
    self.id = id
    self.name = name
    self.category = category
    self.origin = origin
    self.instructions = instructions
    self.image = image
    self.tag = tag
    self.youtube = youtube
    self.source = source
    self.dateModified = dateModified
    self.ingredients = ingredients
    self.favorited = favorited
  }
}
