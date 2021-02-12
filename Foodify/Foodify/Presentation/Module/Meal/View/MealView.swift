//
//  MealView.swift
//  Foodify
//
//  Created by Jamal on 03/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import FoodifyCore
import FoodifyMeal
import SDWebImage
import UIKit

class MealView: UIViewController {
  typealias Presenter = MealPresenter<
    Interactor<
      String,
      MealModel,
      GetMealRepository<
        MealLocaleDataSource,
        MealRemoteDataSource,
        MealTransformer>>,
    Interactor<
      MealModel,
      Bool,
      DoFavoriteRepository<
        MealLocaleDataSource,
        MealTransformer>>>
  let presenter: Presenter
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
  @IBOutlet weak var ingredientsHeader: UILabel!
  @IBOutlet weak var instructionsHeader: UILabel!
  @IBOutlet weak var sourceButton: UIButton!

  private let refreshControl = UIRefreshControl()

  init(presenter: Presenter) {
    self.presenter = presenter
    super.init(nibName: "MealView", bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("MealView hasn't been initiated")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()

    presenter.objectWillChange.receive(on: RunLoop.main).sink {
      self.render()
    }.store(in: &presenter.cancellables)
    presenter.getMeal()
  }

  @IBAction func favoriteDidClick(_ sender: Any) {
    presenter.favorite()
  }

  @IBAction func sourceDidClick(_ sender: Any) {
    openLink(presenter.meal.source)
  }

  @IBAction func youtubeDidClick(_ sender: Any) {
    openLink(presenter.meal.youtube)
  }
}

fileprivate extension MealView {
  func render() {
    switch presenter.state {
    case .loading:
      loadIndicator.startAnimating()
    case .success:
      errorLabel.isHidden = true
      loadIndicator.stopAnimating()
      setView()
    case let .error(error):
      errorLabel.text = error.localizedDescription
      errorLabel.isHidden = false
      loadIndicator.stopAnimating()
      setView()
    default:
      break
    }
  }

  func setup() {
    ingredientsHeader.text = "ingredients".localized(nil) + ":"
    instructionsHeader.text = "instructions".localized(nil) + ":"
    sourceButton.setTitle(" \("source".localized(nil))", for: .normal)

    favoriteButton.accessibilityIdentifier = "favButton"
  }

  func setFavoriteButton() {
    let favImage = presenter.meal.favorited ? "heart.fill" : "heart"
    favoriteButton.setImage(UIImage(systemName: favImage), for: .normal)
  }

  func setView() {
    let meal = presenter.meal
    mealImage.sd_imageIndicator = SDWebImageActivityIndicator.medium
    mealImage.sd_setImage(
      with: URL(string: meal.image ?? ""),
      placeholderImage: UIImage(named: "image_placeholder"),
      options: .progressiveLoad,
      completed: nil
    )
    mealImage.layer.cornerRadius = 30.0
    nameText.text = meal.name
    originText.text = meal.origin
    categoryText.text = meal.category
    instructionsText.text = meal.instructions
    var ingredients = ""
    for (index, ingredient) in meal.ingredients.enumerated() {
      ingredients += ingredient.name + (index + 1 < meal.ingredients.count ? "\n" : "")
    }
    ingredientsText.text = ingredients

    setFavoriteButton()

    if #available(iOS 10.0, *) {
      scrollView.refreshControl = refreshControl
    } else {
      scrollView.addSubview(refreshControl)
    }

    refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
  }

  @objc func refreshData() {
    presenter.getMeal()
    refreshControl.endRefreshing()
  }

  func openLink(_ link: String?) {
    guard let link = URL(string: link ?? "") else { return }
    UIApplication.shared.open(link)
  }
}
