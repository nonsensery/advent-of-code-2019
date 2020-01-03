import XCTest
@testable import SlamShuffle

final class SlamShuffleTests: XCTestCase {
    private func testShuffle(initial: Deck = "0 1 2 3 4 5 6 7 8 9", instructions: String, shuffled: Deck) {
        var deck = initial
        XCTAssertEqual(deck.description, initial.description)

        deck.performAll(instructions)

        XCTAssertEqual(deck.description, shuffled.description)

        deck.reversePerformAll(instructions)

        XCTAssertEqual(deck.description, initial.description)
    }

    func testDeck() {
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

    func testExample1() {
        testShuffle(
            instructions: """
                deal with increment 7
                deal into new stack
                deal into new stack
                """,
            shuffled: "0 3 6 9 2 5 8 1 4 7"
        )
    }

    func testExample2() {
        testShuffle(
            instructions: """
                cut 6
                deal with increment 7
                deal into new stack
                """,
            shuffled: "3 0 7 4 1 8 5 2 9 6"
        )
    }

    func testExample3() {
        testShuffle(
            instructions: """
                deal with increment 7
                deal with increment 9
                cut -2
                """,
            shuffled: "6 3 0 7 4 1 8 5 2 9"
        )
    }

    func testExample4() {
        testShuffle(
            instructions: """
                deal into new stack
                cut -2
                deal with increment 7
                cut 8
                cut -4
                deal with increment 7
                cut 3
                deal with increment 9
                deal with increment 3
                cut -1
                """,
            shuffled: "9 2 5 8 1 4 7 0 3 6"
        )
    }

    func testPart1() {
        var card = Card(value: 2019)

        card.performAll(inputData)

        let result = card.position

        XCTAssertEqual(result, 3377)
    }

    func testPart2() {
        var card = Card(value: 2020, deckSize: 119315717514047)
        let instructions = Instruction.all(inputData)

        for _ in 1...101741582076661 {
            card.reversePerformAll(instructions)
        }

        let result = card.position

        XCTAssertEqual(result, -1)
    }

    static var allTests = [
        ("testExample1", testExample1),
    ]
}
