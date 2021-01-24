//
//  ErrorExtension.swift
//  Foodify
//
//  Created by Jamal on 31/12/20.
//  Copyright © 2020 Kementerian Agama RI. All rights reserved.
//

import Foundation

enum Error: LocalizedError {
  case localizedDescription(String)

  var errorDescription: String? {
    switch self {
    case let .localizedDescription(error):
      return error
    }
  }
}
