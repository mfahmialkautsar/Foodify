//
//  DetailView.swift
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
    setView()
  }

  func setFavoriteButton() {
    guard let detail = presenter.detail else { return }
    let favImage = detail.favorited ? "heart.fill" : "heart"
    favoriteButton.setImage(UIImage(systemName: favImage), for: .normal)
  }

  func setView() {
    guard let detail = presenter.detail else { return }
    mealImage.sd_imageIndicator = SDWebImageActivityIndicator.medium
    mealImage.sd_setImage(
      with: URL(string: detail.image ?? ""),
      placeholderImage: UIImage(named: "image_placeholder"),
      options: .progressiveLoad,
      completed: nil
    )
    nameText.text = detail.name
    originText.text = detail.origin
    categoryText.text = detail.category
    instructionsText.text = detail.instructions
    var ingredients = ""
    ingredients += (!isEmpty(detail.ingredient1, detail.measure1) ?
      "• \(detail.measure1 ?? "") \(detail.ingredient1 ?? "")" : "") +
      measureAndIngredient(measure: detail.measure2, ingredient: detail.ingredient2) +
      measureAndIngredient(measure: detail.measure3, ingredient: detail.ingredient3) +
      measureAndIngredient(measure: detail.measure4, ingredient: detail.ingredient4) +
      measureAndIngredient(measure: detail.measure5, ingredient: detail.ingredient5) +
      measureAndIngredient(measure: detail.measure6, ingredient: detail.ingredient6) +
      measureAndIngredient(measure: detail.measure7, ingredient: detail.ingredient7) +
      measureAndIngredient(measure: detail.measure8, ingredient: detail.ingredient8) +
      measureAndIngredient(measure: detail.measure9, ingredient: detail.ingredient9) +
      measureAndIngredient(measure: detail.measure10, ingredient: detail.ingredient10) +
      measureAndIngredient(measure: detail.measure11, ingredient: detail.ingredient11) +
      measureAndIngredient(measure: detail.measure12, ingredient: detail.ingredient12) +
      measureAndIngredient(measure: detail.measure13, ingredient: detail.ingredient13) +
      measureAndIngredient(measure: detail.measure14, ingredient: detail.ingredient14) +
      measureAndIngredient(measure: detail.measure15, ingredient: detail.ingredient15) +
      measureAndIngredient(measure: detail.measure16, ingredient: detail.ingredient16) +
      measureAndIngredient(measure: detail.measure17, ingredient: detail.ingredient17) +
      measureAndIngredient(measure: detail.measure18, ingredient: detail.ingredient18) +
      measureAndIngredient(measure: detail.measure19, ingredient: detail.ingredient19) +
      measureAndIngredient(measure: detail.measure20, ingredient: detail.ingredient20)
    ingredientsText.text = ingredients

    setFavoriteButton()

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
