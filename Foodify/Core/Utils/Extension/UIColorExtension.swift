//
//  UIColorExtension.swift
//  Foodify
//
//  Created by Jamal on 21/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
  static func random() -> UIColor {
    return UIColor(
      red: .random(),
      green: .random(),
      blue: .random(),
      alpha: 0.3
    )
  }
}
