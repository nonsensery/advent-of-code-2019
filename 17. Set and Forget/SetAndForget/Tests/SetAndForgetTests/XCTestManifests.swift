import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SetAndForgetTests.allTests),
    ]
}
#endif
