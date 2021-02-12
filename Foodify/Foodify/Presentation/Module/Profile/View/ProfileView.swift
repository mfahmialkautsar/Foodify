//
//  ProfileView.swift
//  Foodify
//
//  Created by Jamal on 04/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import FoodifyCommon
import Foundation
import UIKit

class ProfileView: UITableViewController {
  var presenter: ProfilePresenter<ToFavoriteRouter>?
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var profileName: UILabel!
  @IBOutlet weak var favoriteCellText: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "profile".localized(nil)
    favoriteCellText.text = "favorite".localized(nil)
    profileImage.round()
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    switch indexPath {
    case [1, 0]:
      presenter?.toFavorite(view: self)
    default:
      break
    }
  }
}
