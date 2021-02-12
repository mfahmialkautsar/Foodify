//
//  CategoryResponse.swift
//  Foodify
//
//  Created by Jamal on 31/12/20.
//  Copyright © 2020 Kementerian Agama RI. All rights reserved.
//

import Foundation

public struct CategoriesResponse: Decodable {
  let categories: [CategoryResponse]
}

public struct CategoryResponse: Decodable {
  public enum CodingKeys: String, CodingKey {
    case id = "idCategory"
    case name = "strCategory"
    case image = "strCategoryThumb"
    case desc = "strCategoryDescription"
  }

  let id: String?
  let name: String?
  let image: String?
  let desc: String?
}
