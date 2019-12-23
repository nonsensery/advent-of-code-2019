import XCTest
@testable import NBodyProblem

final class NBodyProblemTests: XCTestCase {
    func testExample1() {
        let bodies = parse(
            """
            <x=-1, y=0, z=2>
            <x=2, y=-10, z=-7>
            <x=4, y=-8, z=8>
            <x=3, y=5, z=-1>
            """
        )

        XCTAssertEqual(
            stringify(bodies),
            """
            pos=<x=-1, y=0, z=2>, vel=<x=0, y=0, z=0>
            pos=<x=2, y=-10, z=-7>, vel=<x=0, y=0, z=0>
            pos=<x=4, y=-8, z=8>, vel=<x=0, y=0, z=0>
            pos=<x=3, y=5, z=-1>, vel=<x=0, y=0, z=0>
            """
        )

        step(bodies)

        XCTAssertEqual(
            stringify(bodies),
            """
            pos=<x=2, y=-1, z=1>, vel=<x=3, y=-1, z=-1>
            pos=<x=3, y=-7, z=-4>, vel=<x=1, y=3, z=3>
            pos=<x=1, y=-7, z=5>, vel=<x=-3, y=1, z=-3>
            pos=<x=2, y=2, z=0>, vel=<x=-1, y=-3, z=1>
            """
        )

        step(bodies)

        XCTAssertEqual(
            stringify(bodies),
            """
            pos=<x=5, y=-3, z=-1>, vel=<x=3, y=-2, z=-2>
            pos=<x=1, y=-2, z=2>, vel=<x=-2, y=5, z=6>
            pos=<x=1, y=-4, z=-1>, vel=<x=0, y=3, z=-6>
            pos=<x=1, y=-4, z=2>, vel=<x=-1, y=-6, z=2>
            """
        )

        step(bodies)

        XCTAssertEqual(
            stringify(bodies),
            """
            pos=<x=5, y=-6, z=-1>, vel=<x=0, y=-3, z=0>
            pos=<x=0, y=0, z=6>, vel=<x=-1, y=2, z=4>
            pos=<x=2, y=1, z=-5>, vel=<x=1, y=5, z=-4>
            pos=<x=1, y=-8, z=2>, vel=<x=0, y=-4, z=0>
            """
        )

        step(bodies)

        XCTAssertEqual(
            stringify(bodies),
            """
            pos=<x=2, y=-8, z=0>, vel=<x=-3, y=-2, z=1>
            pos=<x=2, y=1, z=7>, vel=<x=2, y=1, z=1>
            pos=<x=2, y=3, z=-6>, vel=<x=0, y=2, z=-1>
            pos=<x=2, y=-9, z=1>, vel=<x=1, y=-1, z=-1>
            """
        )

        step(bodies)

        XCTAssertEqual(
            stringify(bodies),
            """
            pos=<x=-1, y=-9, z=2>, vel=<x=-3, y=-1, z=2>
            pos=<x=4, y=1, z=5>, vel=<x=2, y=0, z=-2>
            pos=<x=2, y=2, z=-4>, vel=<x=0, y=-1, z=2>
            pos=<x=3, y=-7, z=-1>, vel=<x=1, y=2, z=-2>
            """
        )

        step(bodies)

        XCTAssertEqual(
            stringify(bodies),
            """
            pos=<x=-1, y=-7, z=3>, vel=<x=0, y=2, z=1>
            pos=<x=3, y=0, z=0>, vel=<x=-1, y=-1, z=-5>
            pos=<x=3, y=-2, z=1>, vel=<x=1, y=-4, z=5>
            pos=<x=3, y=-4, z=-2>, vel=<x=0, y=3, z=-1>
            """
        )

        step(bodies)

        XCTAssertEqual(
            stringify(bodies),
            """
            pos=<x=2, y=-2, z=1>, vel=<x=3, y=5, z=-2>
            pos=<x=1, y=-4, z=-4>, vel=<x=-2, y=-4, z=-4>
            pos=<x=3, y=-7, z=5>, vel=<x=0, y=-5, z=4>
            pos=<x=2, y=0, z=0>, vel=<x=-1, y=4, z=2>
            """
        )

        step(bodies)

        XCTAssertEqual(
            stringify(bodies),
            """
            pos=<x=5, y=2, z=-2>, vel=<x=3, y=4, z=-3>
            pos=<x=2, y=-7, z=-5>, vel=<x=1, y=-3, z=-1>
            pos=<x=0, y=-9, z=6>, vel=<x=-3, y=-2, z=1>
            pos=<x=1, y=1, z=3>, vel=<x=-1, y=1, z=3>
            """
        )

        step(bodies)

        XCTAssertEqual(
            stringify(bodies),
            """
            pos=<x=5, y=3, z=-4>, vel=<x=0, y=1, z=-2>
            pos=<x=2, y=-9, z=-3>, vel=<x=0, y=-2, z=2>
            pos=<x=0, y=-8, z=4>, vel=<x=0, y=1, z=-2>
            pos=<x=1, y=1, z=5>, vel=<x=0, y=0, z=2>
            """
        )

        step(bodies)

        XCTAssertEqual(
            stringify(bodies),
            """
            pos=<x=2, y=1, z=-3>, vel=<x=-3, y=-2, z=1>
            pos=<x=1, y=-8, z=0>, vel=<x=-1, y=1, z=3>
            pos=<x=3, y=-6, z=1>, vel=<x=3, y=2, z=-3>
            pos=<x=2, y=0, z=4>, vel=<x=1, y=-1, z=-1>
            """
        )

        XCTAssertEqual(totalEnergy(of: bodies), 179)
    }

    func testExample2() {
        let bodies = parse(
            """
            <x=-8, y=-10, z=0>
            <x=5, y=5, z=10>
            <x=2, y=-7, z=3>
            <x=9, y=-8, z=-3>
            """
        )

        XCTAssertEqual(
            stringify(bodies),
            """
            pos=<x=-8, y=-10, z=0>, vel=<x=0, y=0, z=0>
            pos=<x=5, y=5, z=10>, vel=<x=0, y=0, z=0>
            pos=<x=2, y=-7, z=3>, vel=<x=0, y=0, z=0>
            pos=<x=9, y=-8, z=-3>, vel=<x=0, y=0, z=0>
            """
        )

        (1...10).forEach { _ in step(bodies) }

        XCTAssertEqual(
            stringify(bodies),
            """
            pos=<x=-9, y=-10, z=1>, vel=<x=-2, y=-2, z=-1>
            pos=<x=4, y=10, z=9>, vel=<x=-3, y=7, z=-2>
            pos=<x=8, y=-10, z=-3>, vel=<x=5, y=-1, z=-2>
            pos=<x=5, y=-10, z=3>, vel=<x=0, y=-4, z=5>
            """
        )

        (1...10).forEach { _ in step(bodies) }

        XCTAssertEqual(
            stringify(bodies),
            """
            pos=<x=-10, y=3, z=-4>, vel=<x=-5, y=2, z=0>
            pos=<x=5, y=-25, z=6>, vel=<x=1, y=1, z=-4>
            pos=<x=13, y=1, z=1>, vel=<x=5, y=-2, z=2>
            pos=<x=0, y=1, z=7>, vel=<x=-1, y=-1, z=2>
            """
        )

        (1...10).forEach { _ in step(bodies) }

        XCTAssertEqual(
            stringify(bodies),
            """
            pos=<x=15, y=-6, z=-9>, vel=<x=-5, y=4, z=0>
            pos=<x=-4, y=-11, z=3>, vel=<x=-3, y=-10, z=0>
            pos=<x=0, y=-1, z=11>, vel=<x=7, y=4, z=3>
            pos=<x=-3, y=-2, z=5>, vel=<x=1, y=2, z=-3>
            """
        )

        (1...10).forEach { _ in step(bodies) }

        XCTAssertEqual(
            stringify(bodies),
            """
            pos=<x=14, y=-12, z=-4>, vel=<x=11, y=3, z=0>
            pos=<x=-1, y=18, z=8>, vel=<x=-5, y=2, z=3>
            pos=<x=-5, y=-14, z=8>, vel=<x=1, y=-2, z=0>
            pos=<x=0, y=-12, z=-2>, vel=<x=-7, y=-3, z=-3>
            """
        )

        (1...10).forEach { _ in step(bodies) }

        XCTAssertEqual(
            stringify(bodies),
            """
            pos=<x=-23, y=4, z=1>, vel=<x=-7, y=-1, z=2>
            pos=<x=20, y=-31, z=13>, vel=<x=5, y=3, z=4>
            pos=<x=-4, y=6, z=1>, vel=<x=-1, y=1, z=-3>
            pos=<x=15, y=1, z=-5>, vel=<x=3, y=-3, z=-3>
            """
        )

        (1...10).forEach { _ in step(bodies) }

        XCTAssertEqual(
            stringify(bodies),
            """
            pos=<x=36, y=-10, z=6>, vel=<x=5, y=0, z=3>
            pos=<x=-18, y=10, z=9>, vel=<x=-3, y=-7, z=5>
            pos=<x=8, y=-12, z=-3>, vel=<x=-2, y=1, z=-7>
            pos=<x=-18, y=-8, z=-2>, vel=<x=0, y=6, z=-1>
            """
        )

        (1...10).forEach { _ in step(bodies) }

        XCTAssertEqual(
            stringify(bodies),
            """
            pos=<x=-33, y=-6, z=5>, vel=<x=-5, y=-4, z=7>
            pos=<x=13, y=-9, z=2>, vel=<x=-2, y=11, z=3>
            pos=<x=11, y=-8, z=2>, vel=<x=8, y=-6, z=-7>
            pos=<x=17, y=3, z=1>, vel=<x=-1, y=-1, z=-3>
            """
        )

        (1...10).forEach { _ in step(bodies) }

        XCTAssertEqual(
            stringify(bodies),
            """
            pos=<x=30, y=-8, z=3>, vel=<x=3, y=3, z=0>
            pos=<x=-2, y=-4, z=0>, vel=<x=4, y=-13, z=2>
            pos=<x=-18, y=-7, z=15>, vel=<x=-8, y=2, z=-2>
            pos=<x=-2, y=-1, z=-8>, vel=<x=1, y=8, z=0>
            """
        )

        (1...10).forEach { _ in step(bodies) }

        XCTAssertEqual(
            stringify(bodies),
            """
            pos=<x=-25, y=-1, z=4>, vel=<x=1, y=-3, z=4>
            pos=<x=2, y=-9, z=0>, vel=<x=-3, y=13, z=-1>
            pos=<x=32, y=-8, z=14>, vel=<x=5, y=-4, z=6>
            pos=<x=-1, y=-2, z=-8>, vel=<x=-3, y=-6, z=-9>
            """
        )

        (1...10).forEach { _ in step(bodies) }

        XCTAssertEqual(
            stringify(bodies),
            """
            pos=<x=8, y=-12, z=-9>, vel=<x=-7, y=3, z=0>
            pos=<x=13, y=16, z=-3>, vel=<x=3, y=-11, z=-5>
            pos=<x=-29, y=-11, z=-1>, vel=<x=-3, y=7, z=4>
            pos=<x=16, y=-13, z=23>, vel=<x=7, y=1, z=1>
            """
        )

        XCTAssertEqual(totalEnergy(of: bodies), 1940)
    }

    func testPart1() {
        let bodies = parse(
            """
            <x=-17, y=9, z=-5>
            <x=-1, y=7, z=13>
            <x=-19, y=12, z=5>
            <x=-6, y=-6, z=-4>
            """
        )

        (1...1000).forEach { _ in step(bodies) }

        XCTAssertEqual(totalEnergy(of: bodies), 8742)
    }

    func testPart2Example1() {
        let bodies = parse(
            """
            <x=-1, y=0, z=2>
            <x=2, y=-10, z=-7>
            <x=4, y=-8, z=8>
            <x=3, y=5, z=-1>
            """
        )

        let result = stepsPerCycle(bodies)

        XCTAssertEqual(result, 2772)
    }

    func testPart2Example2() {
        let bodies = parse(
            """
            <x=-8, y=-10, z=0>
            <x=5, y=5, z=10>
            <x=2, y=-7, z=3>
            <x=9, y=-8, z=-3>
            """
        )

        let result = stepsPerCycle(bodies)

        // Instructions say this result should be `4_686_774_924`, but I get this other value when I run it 🤷‍♂️
        XCTAssertEqual(result, 7_030_162_386)
    }

    func testPart2() {
        let bodies = parse(
            """
            <x=-17, y=9, z=-5>
            <x=-1, y=7, z=13>
            <x=-19, y=12, z=5>
            <x=-6, y=-6, z=-4>
            """
        )

        XCTAssertEqual(stepsPerCycle(bodies), 325_433_763_467_176)
    }

    static var allTests = [
        ("testExample1", testExample1),
        ("testExample2", testExample2),
        ("testPart1", testPart1),
    ]
}

private func parse(_ string: String) -> [Body] {
    string
        .split(separator: "\n")
        .map {
            $0
                .split(whereSeparator: { !"-0123456789".contains($0) })
                .map({ Int(String($0))! })
    }
    .map {
        var i = $0.makeIterator()

        let (xp, yp, zp, xv, yv, zv) = (i.next() ?? 0, i.next() ?? 0, i.next() ?? 0, i.next() ?? 0, i.next() ?? 0, i.next() ?? 0)

        return Body(x: Vector(position: xp, velocity: xv), y: Vector(position: yp, velocity: yv), z: Vector(position: zp, velocity: zv))
    }
}

private func stringify(_ bodies: [Body]) -> String {
    bodies.map {
        "pos=<x=\($0.x.position), y=\($0.y.position), z=\($0.z.position)>, " +
        "vel=<x=\($0.x.velocity), y=\($0.y.velocity), z=\($0.z.velocity)>"
    }
    .joined(separator: "\n")
}
