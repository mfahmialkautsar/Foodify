import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FoodifyCommonTests.allTests),
    ]
}
#endif
