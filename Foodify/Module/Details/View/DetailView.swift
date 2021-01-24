//
//  DetailsView.swift
//  Foodify
//
//  Created by Jamal on 03/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import SDWebImage
import UIKit

class DetailView: UIViewController {
  let presenter: DetailPresenter
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var mealImage: UIImageView!
  @IBOutlet weak var nameText: UILabel!
  @IBOutlet weak var originText: UILabel!
  @IBOutlet weak var categoryText: UILabel!
  @IBOutlet weak var ingredientsText: UILabel!
  @IBOutlet weak var instructionsText: UILabel!
  @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
  @IBOutlet weak var favoriteButton: UIButton!
  @IBOutlet weak var errorLabel: UILabel!

  private let refreshControl = UIRefreshControl()

  init(presenter: DetailPresenter) {
    self.presenter = presenter
    super.init(nibName: "DetailView", bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("DetailsViewController hasn't been initiated")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    presenter.objectWillChange.receive(on: RunLoop.main).sink {
      self.render()
    }.store(in: &presenter.cancellables)
    presenter.getDetails()
  }

  @IBAction func favoriteDidClick(_ sender: Any) {
    presenter.favorite()
  }
}

fileprivate extension DetailView {
  func render() {
    switch presenter.state {
    case .loading:
      loadIndicator.startAnimating()
    case .success:
      errorLabel.isHidden = true
      loadIndicator.stopAnimating()
    case let .error(error):
      errorLabel.text = error.localizedDescription
      errorLabel.isHidden = false
      loadIndicator.stopAnimating()
    default:
      break
    }
    guard let details = presenter.details else { return }
    setView(details)
    setFavoriteButton(details)
  }

  func setFavoriteButton(_ details: DetailModel) {
    let favImage = details.favorited ? "heart.fill" : "heart"
    favoriteButton.setImage(UIImage(systemName: favImage), for: .normal)
  }

  func setView(_ details: DetailModel) {
    mealImage.sd_imageIndicator = SDWebImageActivityIndicator.medium
    mealImage.sd_setImage(
      with: URL(string: details.image ?? ""),
      placeholderImage: UIImage(named: "image_placeholder"),
      options: .progressiveLoad,
      completed: nil
    )
    nameText.text = details.name
    originText.text = details.origin
    categoryText.text = details.category
    instructionsText.text = details.instructions
    var ingredients = ""
    ingredients += (!isEmpty(details.ingredient1, details.measure1) ?
      "• \(details.measure1 ?? "") \(details.ingredient1 ?? "")" : "") +
      measureAndIngredient(measure: details.measure2, ingredient: details.ingredient2) +
      measureAndIngredient(measure: details.measure3, ingredient: details.ingredient3) +
      measureAndIngredient(measure: details.measure4, ingredient: details.ingredient4) +
      measureAndIngredient(measure: details.measure5, ingredient: details.ingredient5) +
      measureAndIngredient(measure: details.measure6, ingredient: details.ingredient6) +
      measureAndIngredient(measure: details.measure7, ingredient: details.ingredient7) +
      measureAndIngredient(measure: details.measure8, ingredient: details.ingredient8) +
      measureAndIngredient(measure: details.measure9, ingredient: details.ingredient9) +
      measureAndIngredient(measure: details.measure10, ingredient: details.ingredient10) +
      measureAndIngredient(measure: details.measure11, ingredient: details.ingredient11) +
      measureAndIngredient(measure: details.measure12, ingredient: details.ingredient12) +
      measureAndIngredient(measure: details.measure13, ingredient: details.ingredient13) +
      measureAndIngredient(measure: details.measure14, ingredient: details.ingredient14) +
      measureAndIngredient(measure: details.measure15, ingredient: details.ingredient15) +
      measureAndIngredient(measure: details.measure16, ingredient: details.ingredient16) +
      measureAndIngredient(measure: details.measure17, ingredient: details.ingredient17) +
      measureAndIngredient(measure: details.measure18, ingredient: details.ingredient18) +
      measureAndIngredient(measure: details.measure19, ingredient: details.ingredient19) +
      measureAndIngredient(measure: details.measure20, ingredient: details.ingredient20)
    ingredientsText.text = ingredients

    if #available(iOS 10.0, *) {
      scrollView.refreshControl = refreshControl
    } else {
      scrollView.addSubview(refreshControl)
    }

    refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
  }

  func isEmpty(_ input: String?...) -> Bool {
    return input.allSatisfy {
      guard let input = $0 else { return true }
      return input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
  }

  func measureAndIngredient(measure: String?, ingredient: String?) -> String {
    guard let measure = measure, let ingredient = ingredient, !isEmpty(measure, ingredient) else { return "" }
    return "\n• \(measure) \(ingredient)"
  }

  @objc func refreshData() {
    presenter.getDetails()
    refreshControl.endRefreshing()
  }
}
