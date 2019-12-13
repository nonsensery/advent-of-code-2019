
import SpacePolice
import XCTest

class IntcomputerPaintControllerTests: XCTestCase {
    func testImmediateHalt() {
        var controller = IntcomputerPaintController(program: [99])
        let result = controller.next(.black)

        XCTAssertNil(result)
    }

    func testObserveBlack() {
        var controller = IntcomputerPaintController(program: [3,100, 4,100, 104,0, 99])
        let result = controller.next(.black)

        XCTAssertEqual(result?.0, .black)
    }

    func testObserveWhite() {
        var controller = IntcomputerPaintController(program: [3,100, 4,100, 104,0, 99])
        let result = controller.next(.white)

        XCTAssertEqual(result?.0, .white)
    }

    func testPaintBlack() {
        var controller = IntcomputerPaintController(program: [104,0, 104,0, 99])
        let result = controller.next(.black)

        XCTAssertEqual(result?.0, .black)
    }

    func testPaintWhite() {
        var controller = IntcomputerPaintController(program: [104,1, 104,0, 99])
        let result = controller.next(.black)

        XCTAssertEqual(result?.0, .white)
    }

    func testTurnLeft() {
        var controller = IntcomputerPaintController(program: [104,0, 104,0, 99])
        let result = controller.next(.black)

        XCTAssertEqual(result?.1, .left)
    }

    func testTurnRight() {
        var controller = IntcomputerPaintController(program: [104,0, 104,1, 99])
        let result = controller.next(.black)

        XCTAssertEqual(result?.1, .right)
    }

    func testThreeSteps() {
        let controller = IntcomputerPaintController(program: [
            3,100, 4,100, 104,0,
            3,100, 4,100, 104,1,
            3,100, 4,100, 104,0,
            99
        ])

        var inputs = sequence(first: PaintOperation.Color.black) {
            PaintOperation.Color(rawValue: 1 - $0.rawValue)
        }

        let outputs = sequence(state: controller, next: { $0.next(inputs.next()!) })

        XCTAssertEqual(Array(outputs).map({ $0.0 }), [.black, .white, .black])
        XCTAssertEqual(Array(outputs).map({ $0.1 }), [.left, .right, .left])
    }
}
