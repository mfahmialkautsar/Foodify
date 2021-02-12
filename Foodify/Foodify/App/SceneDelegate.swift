//
//  SceneDelegate.swift
//  Foodify
//
//  Created by Jamal on 31/12/20.
//  Copyright © 2020 Kementerian Agama RI. All rights reserved.
//

import FoodifyCategory
import FoodifyCore
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  let homeUseCase: Interactor<
    String,
    [CategoryModel],
    GetCategoriesRepository<
      Any,
      GetCategoriesRemoteDataSource,
      CategoriesTransformer>> = Injection().provideHome()

  func scene(
    _ scene: UIScene, willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    let homePresenter = HomePresenter(
      useCase: homeUseCase,
      toMealsRouter: ToMealsRouter(),
      toSearchRouter: ToSearchRouter()
    )
    let rootVC = window?.rootViewController as? UITabBarController

    if let homeNavView = rootVC?.children[0],
      let homeView = homeNavView.children[0] as? HomeView {
      homeView.presenter = homePresenter
    }

    if let profileNavView = rootVC?.children[1],
      let profileView = profileNavView.children[0] as? ProfileView {
      profileView.presenter = ProfilePresenter(router: ToFavoriteRouter())
    }

    guard (scene as? UIWindowScene) != nil else { return }
  }

  func sceneDidDisconnect(_ scene: UIScene) {}

  func sceneDidBecomeActive(_ scene: UIScene) {}

  func sceneWillResignActive(_ scene: UIScene) {}

  func sceneWillEnterForeground(_ scene: UIScene) {}

  func sceneDidEnterBackground(_ scene: UIScene) {}
}
