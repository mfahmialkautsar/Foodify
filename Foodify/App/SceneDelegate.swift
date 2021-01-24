//
//  SceneDelegate.swift
//  Foodify
//
//  Created by Jamal on 31/12/20.
//  Copyright © 2020 Kementerian Agama RI. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(
    _ scene: UIScene, willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    let homeUseCase = Injection().provideHome()
    let homePresenter = HomePresenter(homeUseCase: homeUseCase)
    let rootVC = window?.rootViewController as? UITabBarController

    if let homeNavView = rootVC?.children[0],
      let homeView = homeNavView.children[0] as? HomeView {
      homeView.presenter = homePresenter
    }

    if let profileNavView = rootVC?.children[1],
      let profileView = profileNavView.children[0] as? ProfileView {
      profileView.presenter = ProfilePresenter()
    }

    guard (scene as? UIWindowScene) != nil else { return }
  }

  func sceneDidDisconnect(_ scene: UIScene) {}

  func sceneDidBecomeActive(_ scene: UIScene) {}

  func sceneWillResignActive(_ scene: UIScene) {}

  func sceneWillEnterForeground(_ scene: UIScene) {}

  func sceneDidEnterBackground(_ scene: UIScene) {}
}
