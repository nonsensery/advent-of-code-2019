import XCTest
@testable import AmplificationCircuit

final class AmplificationCircuitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(AmplificationCircuit().text, "Hello, World!")
    }
//        func test1() throws {
//    //        let stdin = MyPipe<ComputeValue>()
//    //        let stdout = MyPipe<ComputeValue>()
//    //
//    //        let group = DispatchGroup()
//    //
//    //        DispatchQueue.global().async {
//    //            group.enter()
//    //            try! compute(program: [3,5,4,5,99,0], input: stdin.read, output: stdout.write)
//    //            group.leave()
//    //        }
//    //
//    //        Thread.sleep(forTimeInterval: 1)
//    //
//    //        stdin.write(17)
//    //
//    //        group.wait()
//    //
//    //        print(stdout.read())
//
//            let result = findMaxThrusterSignalWithFeedback(program: [3,5,4,5,99,0], phaseSettings: [0,1])
//        }
//
//        func test2() throws {
//            let result = findMaxThrusterSignalWithFeedback(program: Resource.sample4_txt.values(), phaseSettings: [9, 8, 7, 6, 5])
//            XCTAssertEqual(result, 139629729)
//        }

    static var allTests = [
        ("testExample", testExample),
    ]
}
