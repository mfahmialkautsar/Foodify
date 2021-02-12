//
//  IngredientEntitiy.swift
//  Foodify
//
//  Created by Jamal on 07/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Foundation
import RealmSwift

public class IngredientEntity: Object {
  @objc dynamic var id: String = ""
  @objc dynamic var name: String = ""
  @objc dynamic var mealId: String = ""
}
