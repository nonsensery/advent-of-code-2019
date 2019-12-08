//
//  SpaceImageTests.swift
//  SpaceImageFormatTests
//
//  Created by Alex Johnson on 12/8/19.
//

import XCTest
import SpaceImageFormat

class SpaceImageTests: XCTestCase {
    func testImageFromEmptyData() {
        let result = SpaceImage(data: [], width: 4, height: 3)
        XCTAssertEqual(result, SpaceImage())
    }

    func testSingleLayerImageFromData() {
        let result = SpaceImage(data: [1,1,1,1,2,2,2,2,3,3,3,3], width: 4, height: 3)
        XCTAssertEqual(result, SpaceImage(layers: [.init(pixels: [[1,1,1,1],[2,2,2,2],[3,3,3,3]])]))
    }

    func testMultiLayerImageFromData() {
        let result = SpaceImage(data: [11,11,11,11,12,12,12,12,13,13,13,13,21,21,21,21,22,22,22,22,23,23,23,23], width: 4, height: 3)
        XCTAssertEqual(
            result,
            SpaceImage(layers: [
                .init(pixels: [
                    [11,11,11,11],[12,12,12,12],[13,13,13,13]
                ]),
                .init(pixels: [
                    [21,21,21,21],[22,22,22,22],[23,23,23,23]
                ])
            ])
        )
    }

    //

    func testEmptyImageChecksum() {
        let result = SpaceImage().checksum
        XCTAssertEqual(result, 0)
    }

    func testSingleLayerChecksums() {
        XCTAssertEqual(SpaceImage(data: [0,0,0,0], width: 2, height: 2).checksum, 0)
        XCTAssertEqual(SpaceImage(data: [1,0,0,0], width: 2, height: 2).checksum, 0)
        XCTAssertEqual(SpaceImage(data: [2,0,0,0], width: 2, height: 2).checksum, 0)
        XCTAssertEqual(SpaceImage(data: [1,2,0,0], width: 2, height: 2).checksum, 1)
        XCTAssertEqual(SpaceImage(data: [1,1,2,0], width: 2, height: 2).checksum, 2)
        XCTAssertEqual(SpaceImage(data: [2,2,1,0], width: 2, height: 2).checksum, 2)
        XCTAssertEqual(SpaceImage(data: [1,1,2,2], width: 2, height: 2).checksum, 4)
    }

    func testChecksumUsesLayerWithFewestZeros() {
        XCTAssertEqual(SpaceImage(data: [1,2,9,9, 2,2,1,0], width: 2, height: 2).checksum, 1)
        XCTAssertEqual(SpaceImage(data: [1,2,0,0, 2,2,1,9], width: 2, height: 2).checksum, 2)
    }

    //

    func testEmptyFlattening() {
        let result = SpaceImage().flattened()
        XCTAssertEqual(result, [])
    }

    func testSingleLayerFlattening() {
        let result = SpaceImage(data: [1,1,1,1, 2,2,2,2, 3,3,3,3], width: 4, height: 3).flattened()
        XCTAssertEqual(result, [[1,1,1,1],[2,2,2,2],[3,3,3,3]])
    }

    func testMultiLayerFlattening() {
        let result = SpaceImage(data: [
            11,11,11,11, 12,12,12,12, 13,13,13,13,
            21,21,21,21, 22,22,22,22, 23,23,23,23,
        ], width: 4, height: 3).flattened()
        XCTAssertEqual(result, [[11,11,11,11],[12,12,12,12],[13,13,13,13]])
    }

    func testTransparentColorFlattening() {
        let result = SpaceImage(data: [
            11,11,99,11, 12,12,99,12, 99,13,13,13,
            21,21,21,21, 22,22,22,22, 23,23,23,23,
        ], width: 4, height: 3).flattened(transparent: 99)
        XCTAssertEqual(result, [[11,11,21,11],[12,12,22,12],[23,13,13,13]])
    }
}
