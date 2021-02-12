//
//  DetailEntity.swift
//  Foodify
//
//  Created by Jamal on 31/12/20.
//  Copyright © 2020 Kementerian Agama RI. All rights reserved.
//

import Foundation
import RealmSwift

public class MealEntity: Object {
  @objc dynamic var id: String = ""
  @objc dynamic var name: String = ""
  @objc dynamic var category: String = ""
  @objc dynamic var origin: String = ""
  @objc dynamic var instructions: String = ""
  @objc dynamic var image: String = ""
  @objc dynamic var tag: String = ""
  @objc dynamic var youtube: String = ""
  @objc dynamic var source: String = ""
  @objc dynamic var dateModified: String = ""
  @objc dynamic var favorited: Bool = false
  var ingredients = List<IngredientEntity>()

  override public class func primaryKey() -> String? {
    return "id"
  }
}
