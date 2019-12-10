//
//  IntcomputerTests.swift
//  SensorBoostTests
//
//  Created by Alex Johnson on 12/9/19.
//

import XCTest
import SensorBoost

class IntcomputerTests: XCTestCase {

    func testReadBeyondProgram() throws {
        let output = try compute(program: [4,10_000, 99])
        XCTAssertEqual(output, [0])
    }

    func testWriteBeyondProgram() throws {
        let output = try compute(program: [3,10_000, 4,10_000, 99], input: [1234])
        XCTAssertEqual(output, [1234])
    }

    //

    func testIncreaseRelativeBaseFromImmediate() throws {
        let output = try compute(program: [109,5, 204,0, 99, 1234])
        XCTAssertEqual(output, [1234])
    }

    func testDecreaseRelativeBaseFromImmediate() throws {
        let output = try compute(program: [109,8, 109,-1, 204,0, 99, 1234, 5678])
        XCTAssertEqual(output, [1234])
    }

    func testAdjustRelativeBaseFromAbsoluteAddress() throws {
        let output = try compute(program: [009,6, 204,0, 99, 1234, 5])
        XCTAssertEqual(output, [1234])
    }

    func testAdjustRelativeBaseFromRelativeAddress() throws {
        let output = try compute(program: [
                           // base = `0`
            /* 0 */ 109,4, // base = base + `4` ... base = `4`
            /* 2 */ 209,5, // base = base + mem[base + `5`] ... base = base + mem[`9`] ... base = `7`
            /* 4 */ 204,0, // <= mem[base + `0`] ... <= mem[`7`] ... <= `1234`
            /* 6 */ 99,    // halt
            /* 7 */ 1234,
            /* 8 */ 0,
            /* 9 */ 3
        ])
        XCTAssertEqual(output, [1234])
    }

    func testRelativeReadBefore() throws {
        let output = try compute(program: [109,6, 204,-1, 99, 1234, 5678, 9012])
        XCTAssertEqual(output, [1234])
    }

    func testRelativeReadAfter() throws {
        let output = try compute(program: [109,6, 204,1, 99, 1234, 5678, 9012])
        XCTAssertEqual(output, [9012])
    }
}
