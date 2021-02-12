//
//  Ingredient.swift
//  Foodify
//
//  Created by Jamal on 07/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Foundation

struct Ingredient: Equatable, Identifiable {
  let id: String
  let name: String
  let mealId: String
}
