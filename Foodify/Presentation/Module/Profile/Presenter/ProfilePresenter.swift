//
//  ProfilePresenter.swift
//  Foodify
//
//  Created by Jamal on 11/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Foundation
import UIKit

class ProfilePresenter {
  private let router = ProfileRouter()
  func toFavorite(view: UIViewController) {
    view.navigationController?.pushViewController(router.makeFavorite(), animated: true)
  }
}
