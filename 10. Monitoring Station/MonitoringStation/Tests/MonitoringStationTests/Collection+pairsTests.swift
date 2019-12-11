import XCTest
@testable import MonitoringStation

class Collection_pairsTests: XCTestCase {

    func testEmptyArrayHasNoPairs() {
        let result = Array<Int>().pairs()
        XCTAssertTrue(result.isEmpty)
    }

    func testSingleElementArrayHasNoPairs() {
        let result = [1].pairs()
        XCTAssertTrue(result.isEmpty)
    }

    func testTwoElementArrayHasOnePair() {
        let result = [1, 2].pairs()
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(Set(result.map({ [$0.0, $0.1] })), [[1, 2]])
    }

    func testPairsForManyElements() {
        let result = [1, 2, 3, 4, 5].pairs()
        XCTAssertEqual(result.count, 10)
        XCTAssertEqual(
            Set(result.map({ [$0.0, $0.1] })),
            [[1, 2], [1, 3], [1, 4], [1, 5], [2, 3], [2, 4], [2, 5], [3, 4], [3, 5], [4, 5]]
        )
    }
}
