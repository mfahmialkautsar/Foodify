//
//  SearchRouter.swift
//  Foodify
//
//  Created by Jamal on 23/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Foundation
import UIKit

class SearchRouter {
  func makeDetail(meal: Meal) -> UIViewController {
    let detailUseCase = Injection().provideDetail(meal: meal)
    let presenter = DetailPresenter(detailUseCase: detailUseCase)
    let detailView = DetailView(presenter: presenter)
    detailView.hidesBottomBarWhenPushed = true
    return detailView
  }
}
