//
//  FavoriteMealViewController.swift
//  Foodify
//
//  Created by Jamal on 04/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import UIKit

class FavoriteMealView: UIViewController {
  let presenter: FavoriteMealPresenter

  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
  @IBOutlet weak var errorLabel: UILabel!

  init(presenter: FavoriteMealPresenter) {
    self.presenter = presenter
    super.init(nibName: "FavoriteMealView", bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("FavoriteMealViewController hasn't been initiated")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Favorite"

    setup()
    presenter.objectWillChange.receive(on: RunLoop.main).sink {
      self.render()
    }.store(in: &presenter.cancellables)
    presenter.fetchMeals()
  }
}

fileprivate extension FavoriteMealView {
  func render() {
    switch presenter.state {
    case .loading:
      loadIndicator.startAnimating()
    case .success:
      errorLabel.isHidden = true
      loadIndicator.stopAnimating()
      if presenter.getMeals().isEmpty {
        errorLabel.text = presenter.getKeyword().isEmpty
          ? "You have not added any food to favorite"
          : "\"\(presenter.getKeyword())\" not in Favorite"
        errorLabel.isHidden = false
      }
    case let .error(error):
      errorLabel.text = error.localizedDescription
      errorLabel.isHidden = false
      loadIndicator.stopAnimating()
    default:
      break
    }
    tableView.reloadData()
  }

  func setup() {
    searchBar.delegate = self
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: "MealTableViewCell", bundle: nil), forCellReuseIdentifier: "MealCell")
  }
}

extension FavoriteMealView: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    presenter.getMeals().count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as? MealTableViewCell
    let meal = presenter.getMeals()[indexPath.row]
    cell?.meal = meal
    return cell ?? UITableViewCell()
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    presenter.toDetails(for: indexPath.row, view: self)
  }
}

extension FavoriteMealView: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    presenter.search(keyword: searchText)
  }
}
