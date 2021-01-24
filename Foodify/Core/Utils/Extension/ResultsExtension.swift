//
//  ResultsExtension.swift
//  Foodify
//
//  Created by Jamal on 31/12/20.
//  Copyright © 2020 Kementerian Agama RI. All rights reserved.
//

import Foundation
import RealmSwift

extension Results {
  func final<T>(ofType: T.Type) -> T? {
    var final: T?
    if let result = self as? T {
      final = result
    }
    return final
  }

  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
}
