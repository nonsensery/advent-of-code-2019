import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(PlanetOfDiscordTests.allTests),
    ]
}
#endif
