//
//  Array+chunksTests.swift
//  SpaceImageFormatTests
//
//  Created by Alex Johnson on 12/8/19.
//

import XCTest

class Array_chunksTests: XCTestCase {

    func testEmptyArrayHasEmptyChunks() {
        let result = Array<Int>().chunks(size: 1)
        XCTAssertEqual(result, [])
    }

    func testSingleElementChunks() {
        let result = Array(1...4).chunks(size: 1)
        XCTAssertEqual(result, [[1], [2], [3], [4]])
    }

    func testLongChunks() {
        let result = Array(1...20).chunks(size: 10)
        XCTAssertEqual(result, [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10], [11, 12, 13, 14, 15, 16, 17, 18, 19, 20]])
    }

    func testPartialLastChunk() {
        let result = Array(1...5).chunks(size: 4)
        XCTAssertEqual(result, [[1, 2, 3, 4], [5]])
    }
}
