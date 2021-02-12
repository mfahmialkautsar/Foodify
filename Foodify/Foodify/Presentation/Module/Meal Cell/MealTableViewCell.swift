//
//  MealTableViewCell.swift
//  Foodify
//
//  Created by Jamal on 03/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import SDWebImage
import UIKit

class MealTableViewCell: UITableViewCell {
  @IBOutlet weak var mealImage: UIImageView!
  @IBOutlet weak var mealName: UILabel!
  @IBOutlet weak var mealOrigin: UILabel!
  @IBOutlet weak var mealCategory: UILabel!

  var meal: Meal? {
    willSet {
      if meal != newValue {
        guard let newMeal = newValue else { return }
        render(meal: newMeal)
      }
    }
  }
}

fileprivate extension MealTableViewCell {
  func render(meal: Meal) {
    mealImage.sd_imageIndicator = SDWebImageActivityIndicator.medium
    mealImage.sd_setImage(
      with: URL(string: meal.image ?? ""),
      placeholderImage: UIImage(named: "image_placeholder"),
      options: .progressiveLoad,
      progress: nil,
      completed: nil
    )
    mealImage.layer.cornerRadius = 20
    mealName.text = meal.name
    mealOrigin.text = meal.origin
    mealCategory.text = meal.category
  }
}
