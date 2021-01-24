//
//  CategoryTableViewCell.swift
//  Foodify
//
//  Created by Jamal on 02/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Foundation
import SDWebImage
import UIKit

class CategoryTableViewCell: UITableViewCell {
  @IBOutlet weak var viewContainer: UIView!
  @IBOutlet weak var categoryImage: UIImageView!
  @IBOutlet weak var categoryName: UILabel!

  var category: CategoryModel? {
    didSet {
      guard let category = category else { return }
      render(category: category)
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    setView()
  }
}

fileprivate extension CategoryTableViewCell {
  func render(category: CategoryModel) {
    categoryImage.sd_imageIndicator = SDWebImageActivityIndicator.medium
    categoryImage.sd_setImage(
      with: URL(string: category.image ?? ""),
      placeholderImage: UIImage(named: "image_placeholder"),
      options: .progressiveLoad,
      completed: nil
    )
    categoryName.text = category.name
  }

  func setView() {
    viewContainer.backgroundColor = .random()
    viewContainer.layer.cornerRadius = 30
    viewContainer.layer.masksToBounds = true
  }
}
