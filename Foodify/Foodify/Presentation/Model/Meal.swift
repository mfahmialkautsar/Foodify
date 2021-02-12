//
//  Detail.swift
//  Foodify
//
//  Created by Jamal on 25/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Foundation

struct Meals {
  let detail: [Meal]
}

struct Meal: Equatable, Identifiable {
  let id: String?
  let name: String?
  let category: String?
  let origin: String?
  let instructions: String?
  let image: String?
  let tag: String?
  let youtube: String?
  let source: String?
  let dateModified: String?
  let ingredients: [Ingredient]
  var favorited: Bool = false
}
