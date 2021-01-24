//
//  MealsRouter.swift
//  Foodify
//
//  Created by Jamal on 03/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Foundation
import UIKit

class MealsRouter {
  func makeDetail(meal: MealModel) -> UIViewController {
    let detailUseCase = Injection().provideDetail(meal: meal)
    let presenter = DetailPresenter(detailUseCase: detailUseCase)
    let detailView = DetailView(presenter: presenter)
    detailView.hidesBottomBarWhenPushed = true
    return detailView
  }
}
