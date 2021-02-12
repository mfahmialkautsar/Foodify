//
//  UIImageView+Round.swift
//  Foodify
//
//  Created by Jamal on 21/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
  public func round() {
    layer.masksToBounds = false
    layer.cornerRadius = frame.height / 2
    clipsToBounds = true
  }
}
