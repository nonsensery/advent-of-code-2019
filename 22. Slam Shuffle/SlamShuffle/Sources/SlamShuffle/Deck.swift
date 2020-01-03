
struct Deck: Shufflable {
    private var cards: [Card]

    init(size: Int = 10007) {
        cards = (0 ..< size).map({ Card(value: $0, deckSize: size )})
    }

    init(values: [Int]) {
        cards = zip(values, 0...).map({ Card(value: $0, deckSize: values.count, position: $1) })
    }

    var deckSize: Int {
        cards.count
    }

    var cardValues: [Int] {
        cards.sorted(by: { $0.position < $1.position }).map({ $0.value })
    }

    mutating func dealIntoNewStack() {
        cards.indices.forEach {
            cards[$0].dealIntoNewStack()
        }
        checkUniquePositions()
    }

    mutating func cut(n: Int) {
        cards.indices.forEach {
            cards[$0].cut(n: n)
        }
        checkUniquePositions()
    }

    mutating func deal(increment: Int) {
        cards.indices.forEach {
            cards[$0].deal(increment: increment)
        }
        checkUniquePositions()
    }

    mutating func deal(decrement: Int) {
        cards.indices.forEach {
            cards[$0].deal(decrement: decrement)
        }
        checkUniquePositions()
    }

    private func checkUniquePositions() {
        assert(Set(cards.map({ $0.position })).count == cards.count)
    }
}
