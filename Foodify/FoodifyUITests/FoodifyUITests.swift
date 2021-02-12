//
//  FoodifyUITests.swift
//  FoodifyUITests
//
//  Created by Jamal on 12/02/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import XCTest

class FoodifyUITests: XCTestCase {
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testFavoriteOrUnfavorite() {
    // UI tests must launch the application that they test.
    let app = XCUIApplication()
    app.launch()

    let tablesQuery = app.tables
    let lamb = tablesQuery/*@START_MENU_TOKEN@*/ .staticTexts["Lamb"]/*[[".cells.matching(identifier: \"CategoryCell\").staticTexts[\"Lamb\"]",".staticTexts[\"Lamb\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    guard lamb.waitForExistence(timeout: 10) else { return }
    lamb.tap()

    let scrollViewsQuery = app.scrollViews
    app.swipeUp()
    let mealItem = app/*@START_MENU_TOKEN@*/ .tables.staticTexts["Kapsalon"]/*[[".scrollViews.tables",".cells.matching(identifier: \"MealByCategoryCell\").staticTexts[\"Kapsalon\"]",".staticTexts[\"Kapsalon\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
    guard mealItem.waitForExistence(timeout: 10) else { return }
    mealItem.tap()

    let elementsQuery = scrollViewsQuery.otherElements
    let heartButton = elementsQuery.buttons["favButton"]
    heartButton.tap()
    app.navigationBars.buttons.element(boundBy: 0).tap()
    app.tabBars.buttons["Profile"].tap()
    tablesQuery/*@START_MENU_TOKEN@*/ .staticTexts["Favorite"]/*[[".cells.staticTexts[\"Favorite\"]",".staticTexts[\"Favorite\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ .tap()
    app.swipeDown()
    tablesQuery.searchFields["My favorite foods..."].tap()
    app.typeText("Kapalson")

    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }

  func testLaunchPerformance() {
    if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
      // This measures how long it takes to launch your application.
      measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
        XCUIApplication().launch()
      }
    }
  }
}
