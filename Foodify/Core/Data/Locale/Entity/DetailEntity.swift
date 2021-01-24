//
//  DetailEntity.swift
//  Foodify
//
//  Created by Jamal on 31/12/20.
//  Copyright © 2020 Kementerian Agama RI. All rights reserved.
//

import Foundation
import RealmSwift

class DetailEntity: Object {
  @objc dynamic var id: String = ""
  @objc dynamic var name: String = ""
  @objc dynamic var category: String = ""
  @objc dynamic var origin: String = ""
  @objc dynamic var instructions: String = ""
  @objc dynamic var image: String = ""
  @objc dynamic var tag: String = ""
  @objc dynamic var youtube: String = ""
  @objc dynamic var ingredient1: String = ""
  @objc dynamic var ingredient2: String = ""
  @objc dynamic var ingredient3: String = ""
  @objc dynamic var ingredient4: String = ""
  @objc dynamic var ingredient5: String = ""
  @objc dynamic var ingredient6: String = ""
  @objc dynamic var ingredient7: String = ""
  @objc dynamic var ingredient8: String = ""
  @objc dynamic var ingredient9: String = ""
  @objc dynamic var ingredient10: String = ""
  @objc dynamic var ingredient11: String = ""
  @objc dynamic var ingredient12: String = ""
  @objc dynamic var ingredient13: String = ""
  @objc dynamic var ingredient14: String = ""
  @objc dynamic var ingredient15: String = ""
  @objc dynamic var ingredient16: String = ""
  @objc dynamic var ingredient17: String = ""
  @objc dynamic var ingredient18: String = ""
  @objc dynamic var ingredient19: String = ""
  @objc dynamic var ingredient20: String = ""
  @objc dynamic var measure1: String = ""
  @objc dynamic var measure2: String = ""
  @objc dynamic var measure3: String = ""
  @objc dynamic var measure4: String = ""
  @objc dynamic var measure5: String = ""
  @objc dynamic var measure6: String = ""
  @objc dynamic var measure7: String = ""
  @objc dynamic var measure8: String = ""
  @objc dynamic var measure9: String = ""
  @objc dynamic var measure10: String = ""
  @objc dynamic var measure11: String = ""
  @objc dynamic var measure12: String = ""
  @objc dynamic var measure13: String = ""
  @objc dynamic var measure14: String = ""
  @objc dynamic var measure15: String = ""
  @objc dynamic var measure16: String = ""
  @objc dynamic var measure17: String = ""
  @objc dynamic var measure18: String = ""
  @objc dynamic var measure19: String = ""
  @objc dynamic var measure20: String = ""
  @objc dynamic var source: String = ""
  @objc dynamic var dateModified: String = ""
  @objc dynamic var favorited: Bool = false

  override class func primaryKey() -> String? {
    return "id"
  }
}
