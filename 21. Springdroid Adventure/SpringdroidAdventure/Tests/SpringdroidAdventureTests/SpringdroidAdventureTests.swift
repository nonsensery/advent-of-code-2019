import XCTest
@testable import SpringdroidAdventure

final class SpringdroidAdventureTests: XCTestCase {
    func testPart1() {
        let script = """
            NOT A J
            NOT B T
            OR T J
            NOT C T
            OR T J
            AND D J
            WALK
            """

        let result = assessHullDamage(program: inputData, script: script)

        XCTAssertEqual(result, 19359996)
    }

    func xtestManual() {
        let computer = ASCIIComputer(program: inputData)

        try! computer.run()
    }

    func testPart2() {
        let script = """
            NOT F J
            OR E J
            OR H J
            OR E J
            NOT C T
            AND T J
            NOT B T
            OR T J
            NOT A T
            OR T J
            AND D J
            RUN
            """

        let result = assessHullDamage(program: inputData, script: script)

        XCTAssertEqual(result, 1143330711)
    }

    static var allTests = [
        ("testPart1", testPart1),
    ]
}
