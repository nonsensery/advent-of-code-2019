import XCTest
import MonitoringStation

class HeadingTests: XCTestCase {

    func testAngle() {
        XCTAssertEqual(Heading( 0, -1).angle,   0.00000, accuracy: 0.0005)
        XCTAssertEqual(Heading( 1, -2).angle,  26.56505, accuracy: 0.0001)
        XCTAssertEqual(Heading( 1, -1).angle,  45.00000, accuracy: 0.0001)
        XCTAssertEqual(Heading( 2, -1).angle,  63.43494, accuracy: 0.0001)
        XCTAssertEqual(Heading( 1,  0).angle,  90.00000, accuracy: 0.0001)
        XCTAssertEqual(Heading( 2,  1).angle, 116.56505, accuracy: 0.0001)
        XCTAssertEqual(Heading( 1,  1).angle, 135.00000, accuracy: 0.0001)
        XCTAssertEqual(Heading( 1,  2).angle, 153.43494, accuracy: 0.0001)
        XCTAssertEqual(Heading( 0,  1).angle, 180.00000, accuracy: 0.0001)
        XCTAssertEqual(Heading(-1,  2).angle, 206.56505, accuracy: 0.0001)
        XCTAssertEqual(Heading(-1,  1).angle, 225.00000, accuracy: 0.0001)
        XCTAssertEqual(Heading(-2,  1).angle, 243.43494, accuracy: 0.0001)
        XCTAssertEqual(Heading(-1,  0).angle, 270.00000, accuracy: 0.0001)
        XCTAssertEqual(Heading(-2, -1).angle, 296.56505, accuracy: 0.0001)
        XCTAssertEqual(Heading(-1, -1).angle, 315.00000, accuracy: 0.0001)
        XCTAssertEqual(Heading(-1, -2).angle, 333.43494, accuracy: 0.0001)
    }

}
