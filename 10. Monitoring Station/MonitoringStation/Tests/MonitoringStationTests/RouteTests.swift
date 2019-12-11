import XCTest
import MonitoringStation

class RouteTests: XCTestCase {
    func testBasicInit() {
        XCTAssertEqual(Route(heading: Heading(3, 2), hops: 5).heading.dx, 3)
        XCTAssertEqual(Route(heading: Heading(3, 2), hops: 5).heading.dy, 2)
        XCTAssertEqual(Route(heading: Heading(3, 2), hops: 5).hops, 5)
    }

    func testNormalizesHeadingAndHops() {
        XCTAssertEqual(Route(heading: Heading(9, 6), hops: 5).heading.dx, 3)
        XCTAssertEqual(Route(heading: Heading(9, 6), hops: 5).heading.dy, 2)
        XCTAssertEqual(Route(heading: Heading(9, 6), hops: 5).hops, 15)
    }

    func testBetweenLocations() {
        XCTAssertEqual(Route(from: Location(2, 1), to: Location(5, 3)), Route(heading: Heading(3, 2), hops: 1))
    }
}
