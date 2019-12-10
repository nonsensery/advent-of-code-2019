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
}
