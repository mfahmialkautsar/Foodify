//
//  MealResponse.swift
//  Foodify
//
//  Created by Jamal on 31/12/20.
//  Copyright © 2020 Kementerian Agama RI. All rights reserved.
//

import Foundation

struct MealsResponse: Decodable {
  let meals: [MealResponse]
}

struct MealResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case id = "idMeal"
    case name = "strMeal"
    case image = "strMealThumb"
  }

  let id: String?
  let name: String?
  let image: String?
}
