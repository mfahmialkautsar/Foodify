// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FoodifyMeal",
    platforms: [.iOS(.v13), .macOS(.v10_10)],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "FoodifyMeal",
            targets: ["FoodifyMeal"]),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/realm-cocoa.git", from: "10.5.0"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.4.0")),
        .package(url: "https://github.com/mfahmialkautsar/foodify-core.git", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "FoodifyMeal",
            dependencies: [
              .product(name: "RealmSwift"),
              "FoodifyCore",
              "Alamofire"
        ]),
        .testTarget(
            name: "FoodifyMealTests",
            dependencies: ["FoodifyMeal"]),
    ]
)
