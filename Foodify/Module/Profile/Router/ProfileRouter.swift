//
//  ProfileRouter.swift
//  Foodify
//
//  Created by Jamal on 11/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Foundation
import UIKit

class ProfileRouter {
  func makeFavorite() -> UIViewController {
    let favoriteUseCase = Injection().provideFavorite()
    let presenter = FavoriteMealPresenter(favoriteMealUseCase: favoriteUseCase)
    return FavoriteMealView(presenter: presenter)
  }
}
