//
//  Detail.swift
//  Foodify
//
//  Created by Jamal on 25/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Foundation

struct Details {
  let detail: [DetailModel]
}

struct Detail: Equatable, Identifiable {
  let id: String?
  let name: String?
  let category: String?
  let origin: String?
  let instructions: String?
  let image: String?
  let tag: String?
  let youtube: String?
  let ingredient1: String?
  let ingredient2: String?
  let ingredient3: String?
  let ingredient4: String?
  let ingredient5: String?
  let ingredient6: String?
  let ingredient7: String?
  let ingredient8: String?
  let ingredient9: String?
  let ingredient10: String?
  let ingredient11: String?
  let ingredient12: String?
  let ingredient13: String?
  let ingredient14: String?
  let ingredient15: String?
  let ingredient16: String?
  let ingredient17: String?
  let ingredient18: String?
  let ingredient19: String?
  let ingredient20: String?
  let measure1: String?
  let measure2: String?
  let measure3: String?
  let measure4: String?
  let measure5: String?
  let measure6: String?
  let measure7: String?
  let measure8: String?
  let measure9: String?
  let measure10: String?
  let measure11: String?
  let measure12: String?
  let measure13: String?
  let measure14: String?
  let measure15: String?
  let measure16: String?
  let measure17: String?
  let measure18: String?
  let measure19: String?
  let measure20: String?
  let source: String?
  let dateModified: String?
  var favorited: Bool = false
}
