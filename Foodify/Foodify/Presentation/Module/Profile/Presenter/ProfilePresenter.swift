//
//  ProfilePresenter.swift
//  Foodify
//
//  Created by Jamal on 10/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import FoodifyCore
import UIKit

class ProfilePresenter<ToFavoriteRouter: Router>: ObservableObject {
  let router: ToFavoriteRouter

  init(router: ToFavoriteRouter) {
    self.router = router
  }

  func toFavorite(view: UIViewController) {
    router.go(view: view, request: nil)
  }
}
