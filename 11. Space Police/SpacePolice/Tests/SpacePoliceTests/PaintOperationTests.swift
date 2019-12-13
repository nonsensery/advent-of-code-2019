//
//  PaintOperationTests.swift
//  SpacePoliceTests
//
//  Created by Alex Johnson on 12/12/19.
//

import SpacePolice
import XCTest

class PaintOperationTests: XCTestCase {

    func testInitialState() {
        let op = PaintOperation(controller: MockController(nextBlock: { _ in nil }))

        XCTAssertEqual(
            op.debugState(width: 5, height: 5),
            """
            .....
            .....
            ..^..
            .....
            .....
            """
        )
    }

    func testSize() {
        let op = PaintOperation(controller: MockController(nextBlock: { _ in nil }))

        XCTAssertEqual(
            op.debugState(width: 11, height: 3),
            """
            ...........
            .....^.....
            ...........
            """
        )
    }

    func testTurnLeft() {
        var op = PaintOperation(controller: MockController([(.white, .left)]))
        op.paint()

        XCTAssertEqual(
            op.debugState(width: 5, height: 5),
            """
            .....
            .....
            .<#..
            .....
            .....
            """
        )
    }

    func testTurnRight() {
        var op = PaintOperation(controller: MockController([(.white, .right)]))
        op.paint()

        XCTAssertEqual(
            op.debugState(width: 5, height: 5),
            """
            .....
            .....
            ..#>.
            .....
            .....
            """
        )
    }

    func testCouterClockwiseCircle() {
        var op = PaintOperation(controller: MockController([(.white, .left), (.white, .left), (.white, .left), (.white, .left), (.white, .right)]))
        op.paint()

        XCTAssertEqual(
            op.debugState(width: 5, height: 5),
            """
            .....
            .....
            .##>.
            .##..
            .....
            """
        )
    }

    func testClockwiseCircle() {
        var op = PaintOperation(controller: MockController([(.white, .right), (.white, .right), (.white, .right), (.white, .right), (.white, .left)]))
        op.paint()

        XCTAssertEqual(
            op.debugState(width: 5, height: 5),
            """
            .....
            .....
            .<##.
            ..##.
            .....
            """
        )
    }

    func testPaintOver() {
        var op = PaintOperation(controller: MockController([
            (.white, .right), (.white, .right), (.white, .right), (.white, .right),
            (.black, .right), (.white, .right), (.black, .right), (.white, .left)
        ]))
        op.paint()

        XCTAssertEqual(
            op.debugState(width: 5, height: 5),
            """
            .....
            .....
            ...#.
            ..#..
            ..v..
            """
        )
    }

    func testLongPath() {
        var op = PaintOperation(controller: MockController(
            (.white, .left), (.white, .right), (.white, .left), (.white, .right)
        ))
        op.paint()

        XCTAssertEqual(
            op.debugState(width: 5, height: 5),
            """
            ^....
            ##...
            .##..
            .....
            .....
            """
        )
    }
}

private struct MockController: PaintOperation.Controller {
    let nextBlock: (PaintOperation.Color) -> (PaintOperation.Color, PaintOperation.TurnDirection)?

    func next(_ color: PaintOperation.Color) -> (PaintOperation.Color, PaintOperation.TurnDirection)? {
        nextBlock(color)
    }
}

private extension MockController {
    init<S: Sequence>(_ sequence: S) where S.Element == (PaintOperation.Color, PaintOperation.TurnDirection) {
        var i = sequence.makeIterator()

        self.init(nextBlock: { _ in i.next() })
    }

    init(_ actions: (PaintOperation.Color, PaintOperation.TurnDirection)...) {
        self.init(actions)
    }
}
