import XCTest
@testable import OxygenSystem

final class OxygenSystemTests: XCTestCase {

    func testExpore() {
        let session = RepairDroidSession(program: inputData)
        session.explore()
        let result = session.drawEnvironment()

        XCTAssertEqual(
            result,
            """
            ❔⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️❔⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️❔⬛️⬛️⬛️⬛️⬛️❔
            ⬛️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️⬛️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️⬛️▫️▫️▫️▫️▫️⬛️
            ⬛️▫️⬛️▫️⬛️▫️⬛️⬛️⬛️⬛️⬛️⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️▫️⬛️⬛️⬛️▫️⬛️▫️⬛️
            ⬛️▫️⬛️▫️⬛️▫️⬛️▫️▫️▫️▫️▫️▫️▫️⬛️▫️⬛️▫️▫️▫️▫️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️⬛️▫️⬛️
            ⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️⬛️⬛️⬛️⬛️⬛️⬛️▫️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️▫️⬛️⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️⬛️⬛️▫️⬛️
            ⬛️▫️⬛️▫️⬛️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️▫️▫️⬛️▫️⬛️▫️▫️▫️⬛️▫️⬛️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️▫️▫️⬛️
            ❔⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️▫️⬛️▫️⬛️⬛️⬛️▫️⬛️▫️⬛️⬛️⬛️▫️⬛️⬛️⬛️▫️⬛️⬛️⬛️▫️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️
            ⬛️▫️▫️▫️⬛️▫️▫️▫️▫️▫️⬛️▫️⬛️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️▫️▫️▫️▫️⬛️▫️▫️▫️▫️▫️⬛️▫️⬛️🅾️⬛️▫️▫️▫️⬛️
            ⬛️▫️⬛️⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️⬛️⬛️▫️⬛️▫️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️⬛️⬛️▫️⬛️▫️⬛️▫️⬛️⬛️❔
            ⬛️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️▫️▫️▫️▫️⬛️▫️▫️▫️▫️▫️▫️▫️⬛️▫️⬛️▫️▫️▫️▫️▫️▫️▫️▫️▫️⬛️▫️▫️▫️▫️▫️⬛️
            ⬛️▫️⬛️▫️⬛️⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️❔
            ⬛️▫️⬛️▫️⬛️▫️▫️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️⬛️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️⬛️
            ⬛️▫️⬛️▫️⬛️▫️⬛️⬛️⬛️▫️⬛️▫️⬛️⬛️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️⬛️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️
            ⬛️▫️▫️▫️⬛️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️⬛️▫️⬛️▫️⬛️▫️▫️▫️▫️▫️▫️▫️▫️▫️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️
            ⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️▫️⬛️▫️⬛️⬛️❔⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️
            ⬛️▫️▫️▫️▫️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️⬛️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️⬛️▫️▫️▫️⬛️▫️⬛️
            ❔⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️▫️⬛️⬛️⬛️▫️⬛️▫️⬛️⬛️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️
            ⬛️▫️⬛️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️⬛️▫️⬛️▫️▫️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️⬛️▫️▫️▫️▫️▫️▫️▫️▫️▫️⬛️▫️⬛️
            ⬛️▫️⬛️▫️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️▫️⬛️▫️⬛️⬛️⬛️⬛️❔⬛️⬛️⬛️⬛️▫️⬛️⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️⬛️⬛️▫️⬛️
            ⬛️▫️▫️▫️⬛️▫️▫️▫️▫️▫️▫️▫️⬛️▫️⬛️▫️⬛️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️⬛️▫️▫️▫️▫️▫️▫️▫️⬛️
            ⬛️▫️⬛️⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️▫️⬛️▫️⬛️⬛️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️⬛️⬛️▫️⬛️▫️⬛️▫️⬛️⬛️⬛️⬛️⬛️⬛️❔
            ⬛️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️▫️▫️⬛️▫️▫️▫️▫️▫️⬛️🤖⬛️▫️⬛️▫️▫️▫️⬛️▫️⬛️▫️⬛️▫️▫️▫️▫️▫️▫️▫️⬛️
            ❔⬛️⬛️▫️⬛️▫️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️⬛️⬛️▫️⬛️
            ⬛️▫️▫️▫️⬛️▫️⬛️▫️▫️▫️⬛️▫️⬛️▫️⬛️▫️▫️▫️▫️▫️▫️▫️⬛️▫️▫️▫️▫️▫️⬛️▫️▫️▫️▫️▫️⬛️▫️⬛️▫️▫️▫️⬛️
            ⬛️▫️⬛️⬛️⬛️▫️⬛️⬛️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️▫️⬛️▫️⬛️⬛️❔
            ⬛️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️⬛️▫️▫️▫️⬛️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️▫️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️⬛️▫️▫️▫️⬛️
            ⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️▫️⬛️⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️▫️⬛️⬛️⬛️⬛️⬛️⬛️⬛️▫️⬛️
            ⬛️▫️▫️▫️▫️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️▫️▫️⬛️▫️▫️▫️▫️▫️▫️▫️▫️▫️⬛️
            ❔⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️▫️⬛️⬛️⬛️⬛️❔⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️❔
            ⬛️▫️▫️▫️▫️▫️▫️▫️▫️▫️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️▫️▫️▫️⬛️▫️⬛️▫️▫️▫️⬛️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️▫️▫️⬛️
            ⬛️▫️⬛️⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️⬛️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️⬛️❔
            ⬛️▫️▫️▫️⬛️▫️▫️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️⬛️▫️⬛️▫️⬛️▫️▫️▫️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️▫️▫️▫️⬛️
            ❔⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️▫️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️⬛️⬛️▫️⬛️
            ⬛️▫️⬛️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️⬛️▫️⬛️▫️▫️▫️▫️▫️⬛️▫️⬛️▫️⬛️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️⬛️
            ⬛️▫️⬛️▫️⬛️▫️⬛️▫️⬛️⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️▫️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️▫️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️⬛️❔
            ⬛️▫️⬛️▫️⬛️▫️⬛️▫️▫️▫️▫️▫️⬛️▫️▫️▫️▫️▫️⬛️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️⬛️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️⬛️
            ⬛️▫️⬛️▫️⬛️▫️⬛️⬛️⬛️▫️⬛️⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️⬛️⬛️▫️⬛️▫️⬛️⬛️⬛️▫️⬛️▫️⬛️⬛️⬛️▫️⬛️⬛️⬛️▫️⬛️
            ⬛️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️⬛️▫️▫️▫️▫️▫️▫️▫️⬛️▫️▫️▫️⬛️
            ⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️⬛️⬛️▫️⬛️⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️▫️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️▫️⬛️▫️⬛️
            ⬛️▫️▫️▫️▫️▫️⬛️▫️▫️▫️▫️▫️▫️▫️▫️▫️⬛️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️▫️⬛️▫️⬛️
            ❔⬛️⬛️⬛️⬛️⬛️❔⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️❔⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️❔⬛️❔
            """
        )
    }

    func testPart1() {
        let session = RepairDroidSession(program: inputData)
        session.explore()

        guard let oxygenSystemLocation = session.oxygenSystemLocation else {
            XCTFail("Oxygen system was not found")
            return
        }

        let result = session.mapPathDistances()[oxygenSystemLocation]

        XCTAssertEqual(result, 232)
    }

    func testPart2() {
        let session = RepairDroidSession(program: inputData)
        session.explore()

        guard let oxygenSystemLocation = session.oxygenSystemLocation else {
            XCTFail("Oxygen system was not found")
            return
        }

        let result = session
            .mapPathDistances(from: oxygenSystemLocation)
            .max(by: { $0.value < $1.value })?
            .value

        XCTAssertEqual(result, 320)
    }

    static var allTests = [
        ("testPart1", testPart1),
        ("testPart2", testPart2),
    ]
}

let inputData = [
    3,1033,1008,1033,1,1032,1005,1032,31,1008,1033,2,1032,1005,1032,58,1008,1033,3,1032,1005,1032,81,1008,1033,4,1032,
    1005,1032,104,99,1002,1034,1,1039,102,1,1036,1041,1001,1035,-1,1040,1008,1038,0,1043,102,-1,1043,1032,1,1037,
    1032,1042,1106,0,124,1001,1034,0,1039,102,1,1036,1041,1001,1035,1,1040,1008,1038,0,1043,1,1037,1038,1042,1105,
    1,124,1001,1034,-1,1039,1008,1036,0,1041,1002,1035,1,1040,101,0,1038,1043,1002,1037,1,1042,1106,0,124,1001,1034,
    1,1039,1008,1036,0,1041,1001,1035,0,1040,1002,1038,1,1043,1002,1037,1,1042,1006,1039,217,1006,1040,217,1008,
    1039,40,1032,1005,1032,217,1008,1040,40,1032,1005,1032,217,1008,1039,35,1032,1006,1032,165,1008,1040,7,1032,
    1006,1032,165,1101,2,0,1044,1105,1,224,2,1041,1043,1032,1006,1032,179,1101,1,0,1044,1105,1,224,1,1041,1043,
    1032,1006,1032,217,1,1042,1043,1032,1001,1032,-1,1032,1002,1032,39,1032,1,1032,1039,1032,101,-1,1032,1032,101,
    252,1032,211,1007,0,38,1044,1106,0,224,1101,0,0,1044,1105,1,224,1006,1044,247,1001,1039,0,1034,101,0,1040,
    1035,101,0,1041,1036,102,1,1043,1038,102,1,1042,1037,4,1044,1106,0,0,4,23,34,36,20,5,93,36,72,13,75,47,14,34,
    44,15,61,24,50,12,76,22,40,17,13,24,59,32,99,35,33,5,31,91,44,27,11,21,15,20,99,6,62,16,62,6,14,69,10,53,37,52,
    99,18,92,33,19,99,6,82,13,19,45,15,21,39,59,1,24,39,79,77,35,5,69,79,95,28,49,71,7,83,81,99,58,17,3,98,37,11,
    14,29,44,50,23,75,1,15,67,45,35,44,93,62,31,6,85,81,24,19,22,86,54,19,77,6,4,15,35,40,42,7,9,69,2,53,63,78,94,
    29,82,3,16,64,86,48,36,57,20,54,25,7,89,51,31,52,17,64,51,12,67,6,99,12,17,99,10,73,16,25,57,78,2,4,46,37,96,25,
    9,96,80,6,60,9,7,3,24,52,33,73,23,22,71,24,77,19,96,35,86,50,93,2,75,25,59,14,79,31,54,4,24,87,17,18,88,25,36,
    49,87,22,22,20,76,31,62,18,39,39,35,70,79,37,35,72,26,25,96,8,35,25,60,26,34,5,21,37,79,65,99,50,7,33,54,69,39,
    35,21,72,9,67,16,92,47,65,89,20,77,34,85,24,87,3,49,62,2,81,17,49,31,41,29,80,18,63,2,70,18,96,31,53,70,24,37,
    78,59,20,74,8,67,93,29,24,71,19,23,28,90,10,21,34,49,18,14,48,90,13,54,93,4,96,95,23,26,85,3,3,99,24,43,8,72,
    19,50,17,58,94,5,50,16,12,91,25,68,68,42,27,54,49,2,44,47,31,3,35,66,36,67,2,84,74,14,3,5,63,95,21,23,47,22,61,
    25,28,69,3,50,13,74,96,53,9,32,21,90,8,8,34,66,49,18,34,63,28,90,37,14,43,33,97,12,39,96,31,23,76,14,16,12,74,
    43,10,63,14,20,95,73,1,59,5,40,97,42,47,29,54,64,17,73,44,10,44,43,42,53,37,37,29,48,9,10,18,28,69,62,25,50,53,
    29,15,60,10,74,1,83,21,21,49,19,61,35,30,99,87,10,42,17,4,67,87,6,89,2,21,56,1,80,24,1,64,24,42,95,20,95,77,23,
    29,84,39,5,91,65,16,39,46,36,57,23,30,49,70,21,7,92,22,90,1,25,41,20,35,59,54,98,88,40,23,33,99,5,95,28,73,15,
    72,76,8,2,11,86,23,31,6,69,13,23,93,86,59,24,16,90,23,32,41,11,50,84,58,28,40,3,71,12,86,33,45,34,33,81,23,10,
    33,53,28,81,68,15,96,4,68,3,54,19,73,27,3,21,99,5,47,77,26,28,49,35,92,4,18,1,66,16,1,28,28,66,56,26,23,45,53,
    20,55,32,26,57,67,5,86,73,9,70,2,87,16,75,93,31,78,66,14,76,4,64,24,80,20,45,15,75,17,54,85,16,16,28,45,20,85,
    34,7,2,82,59,25,15,58,92,36,88,46,22,78,6,71,15,23,67,14,71,60,33,56,10,61,7,40,79,37,59,58,37,34,59,17,80,10,
    90,11,89,95,9,37,9,45,60,10,29,73,4,95,42,29,54,49,21,36,65,34,21,94,70,37,86,33,92,84,15,18,72,82,28,12,12,25,
    91,40,68,2,8,83,59,62,4,29,75,79,34,21,99,24,90,79,13,22,92,62,73,19,9,84,46,11,88,32,92,35,58,79,31,4,30,90,
    21,93,14,76,55,48,23,43,13,89,13,67,33,90,86,70,32,65,15,77,32,48,25,61,27,58,2,81,36,59,10,77,5,95,35,41,50,88,
    0,0,21,21,1,10,1,0,0,0,0,0,0
]
