//
//  IngredientModel.swift
//  Foodify
//
//  Created by Jamal on 07/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Foundation

public struct IngredientModel {
  public let id: String
  public let name: String
  public let mealId: String

  public init(
    id: String,
    name: String,
    mealId: String
  ) {
    self.id = id
    self.name = name
    self.mealId = mealId
  }
}
