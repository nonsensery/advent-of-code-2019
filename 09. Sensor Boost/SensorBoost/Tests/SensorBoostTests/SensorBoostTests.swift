import XCTest
@testable import SensorBoost

final class SensorBoostTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SensorBoost().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
