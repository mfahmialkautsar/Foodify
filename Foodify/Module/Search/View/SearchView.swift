//
//  SearchViewController.swift
//  Foodify
//
//  Created by Jamal on 23/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import UIKit

class SearchView: UIViewController {
  private let presenter: SearchPresenter
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
  @IBOutlet weak var errorLabel: UILabel!

  init(presenter: SearchPresenter) {
    self.presenter = presenter
    super.init(nibName: "SearchView", bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("SearchView hasn't been initiated")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Search Meals"
    setup()
    presenter.objectWillChange.receive(on: RunLoop.main).sink {
      self.render()
    }.store(in: &presenter.cancellables)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: true)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
}

fileprivate extension SearchView {
  func render() {
    switch presenter.state {
    case .loading:
      loadIndicator.startAnimating()
    case .success:
      tableView.reloadData()
      loadIndicator.stopAnimating()
      errorLabel.isHidden = true
      tableView.isHidden = false
    case let .error(error):
      errorLabel.text = error.localizedDescription
      tableView.isHidden = true
      errorLabel.isHidden = false
      loadIndicator.stopAnimating()
      switch error.localizedDescription {
      case """
      Response could not be decoded because of error:
      The data couldn’t be read because it is missing.
      """:
        errorLabel.text = "\"\(presenter.getKeyword())\" not found"
      default:
        break
      }
    default:
      break
    }
  }

  func setup() {
    searchBar.delegate = self
    searchBar.becomeFirstResponder()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: "MealTableViewCell", bundle: nil), forCellReuseIdentifier: "MealCell")
  }
}

extension SearchView: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    presenter.details.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as? MealTableViewCell
    let detail = presenter.details[indexPath.row]
    cell?.meal = ModelMapper.mapDetailDomainToMealDomain(input: detail)
    return cell ?? UITableViewCell()
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    presenter.toDetail(for: indexPath.row, view: self)
  }
}

extension SearchView: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    presenter.search(keyword: searchText)
  }
}
