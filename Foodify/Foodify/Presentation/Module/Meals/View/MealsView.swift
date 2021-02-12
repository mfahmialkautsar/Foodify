//
//  MealsView.swift
//  Foodify
//
//  Created by Jamal on 02/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import FoodifyCore
import FoodifyMeal
import Foundation
import SDWebImage
import UIKit

class MealsView: UIViewController {
  typealias Presenter = MealsPresenter<
    Interactor<
      String,
      [MealModel],
      GetMealsRepository<
        MealLocaleDataSource,
        MealsRemoteDataSource,
        MealsTransformer>>,
    ToMealRouter>
  let presenter: Presenter

  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var mealTableView: UITableView!
  @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
  @IBOutlet weak var mealCategoryName: UILabel!
  @IBOutlet weak var mealCategoryDesc: UILabel!
  @IBOutlet weak var mealImage: UIImageView!
  @IBOutlet weak var errorLabel: UILabel!

  private let refreshControl = UIRefreshControl()

  init(presenter: Presenter) {
    self.presenter = presenter
    super.init(nibName: "MealsView", bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("MealsView hasn't been initialized")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTable()
    scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y), animated: true)
    scrollView.isDirectionalLockEnabled = true

    setView()
    presenter.objectWillChange.receive(on: RunLoop.main).sink {
      self.render()
    }.store(in: &presenter.cancellables)
    presenter.getMeals()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.title = ""
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationItem.title = presenter.category?.name
  }
}

fileprivate extension MealsView {
  func setView() {
    mealImage.sd_imageIndicator = SDWebImageActivityIndicator.medium
    mealImage.sd_setImage(
      with: URL(string: presenter.category?.image ?? ""),
      placeholderImage: UIImage(named: "image_placeholder"),
      options: .progressiveLoad,
      completed: nil
    )
    mealImage.layer.cornerRadius = 20
    mealCategoryName.text = presenter.category?.name
    mealCategoryDesc.text = presenter.category?.desc
  }

  func render() {
    switch presenter.state {
    case .loading:
      loadIndicator.startAnimating()
    case .success:
      errorLabel.isHidden = true
      mealTableView.reloadData()
      setTableHeigh()
      loadIndicator.stopAnimating()
    case let .error(error):
      errorLabel.text = error.localizedDescription
      errorLabel.isHidden = true
      loadIndicator.stopAnimating()
    default:
      break
    }
  }

  func setTableHeigh() {
    var tableHeight: CGFloat = 0
    for i in 0 ..< tableView(mealTableView, numberOfRowsInSection: 0) {
      tableHeight += mealTableView.rectForRow(at: IndexPath(row: i, section: 0)).height
    }
    mealTableView.translatesAutoresizingMaskIntoConstraints = true
    mealTableView.frame.size.height = tableHeight
  }

  func setupTable() {
    mealTableView.delegate = self
    mealTableView.dataSource = self
    mealTableView.register(
      UINib(nibName: "MealByCategoryTableViewCell", bundle: nil),
      forCellReuseIdentifier: "MealByCategoryCell"
    )

    if #available(iOS 10.0, *) {
      scrollView.refreshControl = refreshControl
    } else {
      scrollView.addSubview(refreshControl)
    }

    refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
  }

  @objc func refreshData() {
    presenter.getMeals()
    refreshControl.endRefreshing()
  }
}

extension MealsView: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    presenter.meals.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MealByCategoryCell", for: indexPath)
      as? MealByCategoryTableViewCell
      let meal = presenter.meals[indexPath.row]
      cell?.meal = meal
    return cell ?? UITableViewCell()
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    presenter.toMeal(for: indexPath.row, view: self)
  }
}
