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
  @IBOutlet weak var viewContainer: UIView!
  @IBOutlet weak var mealImage: UIImageView!
  @IBOutlet weak var mealName: UILabel!

  var meal: MealModel? {
    willSet {
      if meal != newValue {
        guard let newMeal = newValue else { return }
        render(meal: newMeal)
      }
    }
  }

  override func awakeFromNib() {
    setView()
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
}

fileprivate extension MealTableViewCell {
  func render(meal: MealModel) {
    mealImage.sd_imageIndicator = SDWebImageActivityIndicator.medium
    mealImage.sd_setImage(
      with: URL(string: meal.image ?? ""),
      placeholderImage: UIImage(named: "image_placeholder"),
      options: .progressiveLoad,
      progress: nil,
      completed: nil
    )
    mealName.text = meal.name
  }

  func setView() {
    viewContainer.backgroundColor = .random()
    viewContainer.layer.cornerRadius = 30
    viewContainer.layer.masksToBounds = true
  }
}
