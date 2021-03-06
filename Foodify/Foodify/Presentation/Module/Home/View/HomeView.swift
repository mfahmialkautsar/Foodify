//
//  HomeView.swift
//  Foodify
//
//  Created by Jamal on 31/12/20.
//  Copyright © 2020 Kementerian Agama RI. All rights reserved.
//

import FoodifyCategory
import FoodifyCommon
import FoodifyCore
import UIKit

class HomeView: UIViewController {
  typealias Presenter = HomePresenter<
    Interactor<
      String,
      [CategoryModel],
      GetCategoriesRepository<
        Any,
        GetCategoriesRemoteDataSource,
        CategoriesTransformer
      >
    >,
    ToMealsRouter,
    ToSearchRouter
  >
  var presenter: Presenter?
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
  @IBOutlet weak var errorLabel: UILabel!

  private let refreshControl = UIRefreshControl()

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.title = "food_categories".localized(nil)
    setup()
    setupTableView()
    guard let presenter = presenter else { return }
    presenter.objectWillChange.receive(on: RunLoop.main).sink {
      self.render(presenter: presenter)
    }.store(in: &presenter.cancellables)
    presenter.getCategories()
  }

  @IBAction func searchButton(_ sender: Any) {
    presenter?.toSearch(view: self)
  }
}

fileprivate extension HomeView {
  func render(presenter: Presenter) {
    switch presenter.state {
    case .loading:
      loadIndicator.startAnimating()
    case .success:
      errorLabel.isHidden = true
      tableView.reloadData()
      loadIndicator.stopAnimating()
    case let .error(error):
      errorLabel.text = error.localizedDescription
      errorLabel.isHidden = false
      loadIndicator.stopAnimating()
    default:
      break
    }
  }

  func setup() {
    let tabBars = tabBarController?.tabBar.items
    tabBars?[0].title = "home".localized(nil)
    tabBars?[1].title = "profile".localized(nil)
  }

  func setupTableView() {
    tableView?.delegate = self
    tableView?.dataSource = self
    tableView?.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")

    if #available(iOS 10.0, *) {
      tableView?.refreshControl = refreshControl
    } else {
      tableView?.addSubview(refreshControl)
    }

    refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
  }

  @objc func refreshData() {
    presenter?.getCategories()
    refreshControl.endRefreshing()
  }
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    presenter?.categories.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryTableViewCell
    if let presenter = presenter {
      let category = presenter.categories[indexPath.row]
      cell?.category = category
    }
    return cell ?? UITableViewCell()
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    presenter?.toMeals(for: indexPath.row, view: self)
  }
}
