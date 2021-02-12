//
//  MealByCategoryTableViewCell.swift
//  Foodify
//
//  Created by Jamal on 12/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import SDWebImage
import UIKit

class MealByCategoryTableViewCell: UITableViewCell {
  @IBOutlet weak var mealImage: UIImageView!
  @IBOutlet weak var mealName: UILabel!

  var meal: Meal? {
    willSet {
      if meal != newValue {
        guard let newMeal = newValue else { return }
        render(meal: newMeal)
      }
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
}

fileprivate extension MealByCategoryTableViewCell {
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
  }
}
