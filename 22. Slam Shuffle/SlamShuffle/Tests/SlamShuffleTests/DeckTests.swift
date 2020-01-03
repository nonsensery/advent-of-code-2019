//
//  DeckTests.swift
//  SlamShuffleTests
//
//  Created by Alex Johnson on 12/23/19.
//

import XCTest
@testable import SlamShuffle

class DeckTests: XCTestCase {

    func testDealIntoNewStack() {
        let instructions = """
            deal into new stack
            """

        var deck: Deck = "0 1 2 3 4 5 6 7 8 9"
        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")

        deck.performAll(instructions)

        XCTAssertEqual(deck.description, "9 8 7 6 5 4 3 2 1 0")

        deck.reversePerformAll(instructions)

        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")
    }

    func testDealWithSmallIncrement() {
        let instructions = """
            deal with increment 3
            """

        var deck: Deck = "0 1 2 3 4 5 6 7 8 9"
        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")

        deck.performAll(instructions)

        XCTAssertEqual(deck.description, "0 7 4 1 8 5 2 9 6 3")

        deck.reversePerformAll(instructions)

        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")
    }

    func testDealWithLargeIncrement() {
        let instructions = """
            deal with increment 7
            """

        var deck: Deck = "0 1 2 3 4 5 6 7 8 9"
        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")

        deck.performAll(instructions)

        XCTAssertEqual(deck.description, "0 3 6 9 2 5 8 1 4 7")

        deck.reversePerformAll(instructions)

        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")
    }
//
//    func testDealWithSmallNegativeIncrement() {
//        let instructions = """
//            deal with increment -3
//            """
//
//        var deck: Deck = "0 1 2 3 4 5 6 7 8 9"
//        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")
//
//        deck.performAll(instructions)
//
//        XCTAssertEqual(deck.description, "0 3 6 9 2 5 8 1 4 7")
//
//        deck.reversePerformAll(instructions)
//
//        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")
//    }
//
//    func testDealWithLargeNegativeIncrement() {
//        let instructions = """
//            deal with increment -7
//            """
//
//        var deck: Deck = "0 1 2 3 4 5 6 7 8 9"
//        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")
//
//        deck.performAll(instructions)
//
//        XCTAssertEqual(deck.description, "0 7 4 1 8 5 2 9 6 3")
//
//        deck.reversePerformAll(instructions)
//
//        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")
//    }

    func testDealWithIncrement9() {
        let instructions = """
            deal with increment 9
            """

        var deck: Deck = "0 1 2 3 4 5 6 7 8 9"
        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")

        deck.performAll(instructions)

        XCTAssertEqual(deck.description, "0 9 8 7 6 5 4 3 2 1")

        deck.reversePerformAll(instructions)

        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")
    }
//
//    func testDealWithEvenIncrement() {
//        let instructions = """
//            deal with increment 4
//            """
//
//        var deck: Deck = "0 1 2 3 4 5 6 7 8 9"
//        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")
//
//        deck.performAll(instructions)
//
//        XCTAssertEqual(deck.description, "")
//
//        deck.reversePerformAll(instructions)
//
//        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")
//    }

    func testCutWithSmallOffset() {
        let instructions = """
            cut 3
            """

        var deck: Deck = "0 1 2 3 4 5 6 7 8 9"
        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")

        deck.performAll(instructions)

        XCTAssertEqual(deck.description, "3 4 5 6 7 8 9 0 1 2")

        deck.reversePerformAll(instructions)

        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")
    }

    func testCutWithLargeOffset() {
        let instructions = """
            cut 8
            """

        var deck: Deck = "0 1 2 3 4 5 6 7 8 9"
        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")

        deck.performAll(instructions)

        XCTAssertEqual(deck.description, "8 9 0 1 2 3 4 5 6 7")

        deck.reversePerformAll(instructions)

        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")
    }

    func testCutWithSmallNegativeOffset() {
        let instructions = """
            cut -3
            """

        var deck: Deck = "0 1 2 3 4 5 6 7 8 9"
        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")

        deck.performAll(instructions)

        XCTAssertEqual(deck.description, "7 8 9 0 1 2 3 4 5 6")

        deck.reversePerformAll(instructions)

        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")
    }

    func testCutWithLargeNegativeOffset() {
        let instructions = """
            cut -8
            """

        var deck: Deck = "0 1 2 3 4 5 6 7 8 9"
        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")

        deck.performAll(instructions)

        XCTAssertEqual(deck.description, "2 3 4 5 6 7 8 9 0 1")

        deck.reversePerformAll(instructions)

        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")
    }

    func testTwoInstructions() {
        let instructions = """
            deal into new stack
            cut 3
            """

        var deck: Deck = "0 1 2 3 4 5 6 7 8 9"
        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")

        deck.performAll(instructions)

        XCTAssertEqual(deck.description, "6 5 4 3 2 1 0 9 8 7")

        deck.reversePerformAll(instructions)

        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")
    }

    func testThreeInstructions() {
        let instructions = """
            deal into new stack
            cut 3
            deal with increment 3
            """

        var deck: Deck = "0 1 2 3 4 5 6 7 8 9"
        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")

        deck.performAll(instructions)

//        XCTAssertEqual(deck.description, "6 5 4 3 2 1 0 9 8 7")
        XCTAssertEqual(deck.description, "6 9 2 5 8 1 4 7 0 3")

        deck.reversePerformAll(instructions)

        XCTAssertEqual(deck.description, "0 1 2 3 4 5 6 7 8 9")
    }

}
