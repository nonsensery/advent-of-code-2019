
protocol Shufflable {
    var deckSize: Int { get }

    mutating func dealIntoNewStack()
    mutating func cut(n: Int)
    mutating func deal(increment: Int)
    mutating func deal(decrement: Int)
}

extension Shufflable {
    mutating func reverseDealIntoNewStack() {
        dealIntoNewStack()
    }

    mutating func reverseCut(n: Int) {
        cut(n: -n)
    }

    mutating func reverseDeal(increment: Int) {
        deal(decrement: increment)
    }
}
