//
//  CategoryModel.swift
//  Foodify
//
//  Created by Jamal on 31/12/20.
//  Copyright © 2020 Kementerian Agama RI. All rights reserved.
//

public struct CategoryModel {
  public let id: String?
  public let name: String?
  public let image: String?
  public let desc: String?

  public init(
    id: String?,
    name: String?,
    image: String?,
    desc: String?
  ) {
    self.id = id
    self.name = name
    self.image = image
    self.desc = desc
  }
}
