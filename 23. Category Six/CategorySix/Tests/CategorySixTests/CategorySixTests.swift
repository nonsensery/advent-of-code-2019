import XCTest
@testable import CategorySix

final class CategorySixTests: XCTestCase {
    func testPart1() {
        let result = simulateNetwork(program: inputData)
        XCTAssertEqual(result, 16685)
    }

    func testPart2() {
        let result = simulateNetworkWithNAT(program: inputData)
        XCTAssertEqual(result, 11048)
    }

    static var allTests = [
        ("testPart1", testPart1),
    ]
}
