//
//  Part2Tests.swift
//  AmplificationCircuitTests
//
//  Created by Alex Johnson on 12/7/19.
//

import XCTest
import AmplificationCircuit

final class Part2Tests: XCTestCase {
    func testSample1() throws {
        let program: Memory = [
            3,26,
            1001,26,-4,26,
            3,27,
            1002,27,2,27,
            1,27,26,27,
            4,27,
            1001,28,-1,28,
            1005,28,6,
            99,
            0,
            0,
            5
        ]

        let result = try findMaxThrusterSignalWithFeedback(program: program, phaseSettings: [9,8,7,6,5])

        XCTAssertEqual(result, 139_629_729)
    }

    func testSample1Complete() throws {
        let program: Memory = [
            3,26,
            1001,26,-4,26,
            3,27,
            1002,27,2,27,
            1,27,26,27,
            4,27,
            1001,28,-1,28,
            1005,28,6,
            99,
            0,
            0,
            5
        ]

        let result = try findMaxThrusterSignalAndPhaseSettingsWithFeedback(program: program, phaseSettings: Array(5...9))

        XCTAssertEqual(result?.thrusterSignal, 139_629_729)
        XCTAssertEqual(result?.phaseSettings, [9,8,7,6,5])
    }

    func testSample2() throws {
        let program: Memory = [
            3,52,
            1001,52,-5,52,
            3,53,
            1,52,56,54,
            1007,54,5,55,
            1005,55,26,
            1001,54,-5,54,
            1105,1,12,1,
            53,
            54,
            53,
            1008,54,0,55,
            1001,55,1,55,
            2,53,55,53,
            4,53,
            1001,56,-1,56,
            1005,56,6,
            99,
            0,
            0,
            0,
            0,
            10
        ]

        let result = try findMaxThrusterSignalWithFeedback(program: program, phaseSettings: [9,7,8,5,6])

        XCTAssertEqual(result, 18_216)
    }

    func test2Complete() throws {
        let program: Memory = [
            3,52,
            1001,52,-5,52,
            3,53,
            1,52,56,54,
            1007,54,5,55,
            1005,55,26,
            1001,54,-5,54,
            1105,1,12,1,
            53,
            54,
            53,
            1008,54,0,55,
            1001,55,1,55,
            2,53,55,53,
            4,53,
            1001,56,-1,56,
            1005,56,6,
            99,
            0,
            0,
            0,
            0,
            10
        ]

        let result = try findMaxThrusterSignalAndPhaseSettingsWithFeedback(program: program, phaseSettings: Array(5...9))

        XCTAssertEqual(result?.thrusterSignal, 18_216)
        XCTAssertEqual(result?.phaseSettings, [9,7,8,5,6])
    }

    func testMyInputComplete() throws {
        let program = [
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

        let result = try findMaxThrusterSignalAndPhaseSettingsWithFeedback(program: program, phaseSettings: Array(5...9))

        XCTAssertEqual(result?.thrusterSignal, 21_596_786)
        XCTAssertEqual(result?.phaseSettings, [9,5,8,6,7])
    }

}
