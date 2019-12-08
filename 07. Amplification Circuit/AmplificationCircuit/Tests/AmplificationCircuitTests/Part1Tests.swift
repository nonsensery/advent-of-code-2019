//
//  Part1Tests.swift
//  AmplificationCircuitTests
//
//  Created by Alex Johnson on 12/7/19.
//

import XCTest
import AmplificationCircuit

final class Part1Tests: XCTestCase {
    func testSample1() throws {
        let program: Memory = [
            3,15,
            3,16,
            1002,16,10,16,
            1,16,15,15,
            4,15,
            99,
            0,
            0
        ]

        let result = try findMaxThrusterSignal(program: program, phaseSettings: [4,3,2,1,0])

        XCTAssertEqual(result, 43_210)
    }

    func testSample1Complete() throws {
        let program: Memory = [
            3,15,
            3,16,
            1002,16,10,16,
            1,16,15,15,
            4,15,
            99,
            0,
            0
        ]

        let result = try findMaxThrusterSignalAndPhaseSettings(program: program, phaseSettings: Array(0...4))

        XCTAssertEqual(result?.thrusterSignal, 43_210)
        XCTAssertEqual(result?.phaseSettings, [4,3,2,1,0])
    }

    func testSample2() throws {
        let program: Memory = [
            3,23,
            3,24,
            1002,24,10,24,
            1002,23,-1,23,
            101,5,23,23,
            1,24,23,23,
            4,23,
            99,
            0,
            0
        ]

        let result = try findMaxThrusterSignal(program: program, phaseSettings: [0,1,2,3,4])

        XCTAssertEqual(result, 54_321)
    }

    func testSample2Complete() throws {
        let program: Memory = [
            3,23,
            3,24,
            1002,24,10,24,
            1002,23,-1,23,
            101,5,23,23,
            1,24,23,23,
            4,23,
            99,
            0,
            0
        ]

        let result = try findMaxThrusterSignalAndPhaseSettings(program: program, phaseSettings: Array(0...4))

        XCTAssertEqual(result?.thrusterSignal, 54_321)
        XCTAssertEqual(result?.phaseSettings, [0,1,2,3,4])
    }

    func testSample3() throws {
        let program: Memory = [
            3,31,
            3,32,
            1002,32,10,32,
            1001,31,-2,31,
            1007,31,0,33,
            1002,33,7,33,
            1,33,31,31,
            1,32,31,31,
            4,31,
            99,
            0,
            0,
            0
        ]

        let result = try findMaxThrusterSignal(program: program, phaseSettings: [1,0,4,3,2])

        XCTAssertEqual(result, 65_210)
    }

    func testSample3Complete() throws {
        let program: Memory = [
            3,31,
            3,32,
            1002,32,10,32,
            1001,31,-2,31,
            1007,31,0,33,
            1002,33,7,33,
            1,33,31,31,
            1,32,31,31,
            4,31,
            99,
            0,
            0,
            0
        ]

        let result = try findMaxThrusterSignalAndPhaseSettings(program: program, phaseSettings: Array(0...4))

        XCTAssertEqual(result?.thrusterSignal, 65_210)
        XCTAssertEqual(result?.phaseSettings, [1,0,4,3,2])
    }

    func testMyInputComplete() throws {
        let program: Memory = [
            3,8,1001,8,10,8,105,1,0,0,21,38,47,64,85,106,187,268,349,430,99999,3,9,1002,9,4,9,1001,9,4,9,1002,9,4,9,
            4,9,99,3,9,1002,9,4,9,4,9,99,3,9,1001,9,3,9,102,5,9,9,1001,9,5,9,4,9,99,3,9,101,3,9,9,102,5,9,9,1001,9,
            4,9,102,4,9,9,4,9,99,3,9,1002,9,3,9,101,2,9,9,102,4,9,9,101,2,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,102,2,9,
            9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,
            102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,99,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,
            1,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,
            9,101,2,9,9,4,9,3,9,101,1,9,9,4,9,99,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,
            2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,
            1002,9,2,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,
            2,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,99,3,
            9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,
            9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,99
        ]

        let result = try findMaxThrusterSignalAndPhaseSettings(program: program, phaseSettings: Array(0...4))

        XCTAssertEqual(result?.thrusterSignal, 366_376)
        XCTAssertEqual(result?.phaseSettings, [2,3,0,4,1])
    }
}
