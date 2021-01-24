//
//  StringExtension.swift
//  Foodify
//
//  Created by Jamal on 10/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Foundation
import UIKit

extension String {
  func toHtml(label: UILabel) -> NSAttributedString {
    let formatted = String(
      format: "<span style=\"font-family: \(label.font.familyName); font-size: \(label.font.pointSize)\">%@</span>",
      self
    )
    if let data = formatted.data(using: .unicode),
      let attributedString =
      try? NSAttributedString(
        data: data,
        options: [.documentType: NSAttributedString.DocumentType.html],
        documentAttributes: nil
      ) {
      return attributedString
    }
    return NSAttributedString()
  }
}
