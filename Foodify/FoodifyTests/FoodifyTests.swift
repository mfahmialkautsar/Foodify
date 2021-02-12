//
//  FoodifyTests.swift
//  FoodifyTests
//
//  Created by Jamal on 12/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

@testable import Foodify
import FoodifyCommon
import XCTest

class FoodifyTests: XCTestCase {
  let homeViewController = HomeView()

  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testNavItemTitle() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    homeViewController.beginAppearanceTransition(true, animated: true)
    XCTAssertEqual(homeViewController.navigationItem.title, "food_categories".localized(nil))
  }

  func testPerformanceExample() {
    // This is an example of a performance test case.
    measure {
      // Put the code you want to measure the time of here.
    }
  }
}
