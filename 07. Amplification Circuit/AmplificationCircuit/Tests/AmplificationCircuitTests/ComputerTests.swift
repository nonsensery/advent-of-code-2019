//
//  ComputerTests.swift
//  AmplificationCircuitTests
//
//  Created by Alex Johnson on 12/7/19.
//

import XCTest
import AmplificationCircuit

final class ComputerTests: XCTestCase {

    func testHalt() throws {
        let c = Computer(instructions: 99)
        XCTAssert(!c.isHalted)
        try c.tick()
        XCTAssert(c.isHalted)
    }

    func testBasicOutput() throws {
        let c = Computer(instructions: 4,3, 99, 1_234)
        try c.tick()
        XCTAssertEqual(c.output.read(), 1_234)
    }

    func testInputOutput() throws {
        let c = Computer(instructions: 3,200, 4,200, 99)
        c.input.write(1234)
        while !c.isHalted {
            try c.tick()
        }
        XCTAssertEqual(c.output.read(), 1_234)
    }

    func testInputMutateOutput() throws {
        let c = Computer(instructions: 3,200, 1001,200,5_678,200, 4,200, 99)
        c.input.write(1_234)
        while !c.isHalted {
            try c.tick()
        }
        XCTAssertEqual(c.output.read(), 6_912)
    }

    func testOutputToInput() throws {
        let c1 = Computer(instructions: 3,200, 1001,200,5_678,200, 4,200, 99)
        let c2 = Computer(instructions: 3,200, 1001,200,9_012,200, 4,200, 99)

        c2.input = c1.output
        c1.input.write(1_234)

        while !c1.isHalted || !c2.isHalted {
            try c1.tick()
            try c2.tick()
        }

        XCTAssertEqual(c2.output.read(), 15_924)
    }

    func testOutputsToInputs() throws {
        let cs = (1...5).map {
            Computer(instructions: 3,200, 1001,200,$0,200, 4,200, 99)
        }

        zip(cs, cs.dropFirst()).forEach {
            $0.1.input = $0.0.output
        }

        cs.first?.input.write(1_234)

        while cs.contains(where: { !$0.isHalted }) {
            try cs.forEach({ try $0.tick() })
        }

        XCTAssertEqual(cs.last?.output.read(), 1_249)
    }

}
