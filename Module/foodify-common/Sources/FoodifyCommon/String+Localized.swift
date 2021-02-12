//
//  String+Localized.swift
//  Foodify
//
//  Created by Jamal on 12/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Foundation

extension String {
  public func localized(_ identifier: String?) -> String {
    let bundle = Bundle(identifier: identifier ?? "id.go.kemenag.Foodify") ?? .main
    return bundle.localizedString(forKey: self, value: nil, table: nil)
  }
}
