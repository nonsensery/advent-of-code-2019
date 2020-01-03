
struct Card: Shufflable {
    let value: Int
    let deckSize: Int
    var position: Int

    init(value: Int, deckSize: Int = 10007, position: Int? = nil) {
        self.value = value
        self.deckSize = deckSize
        self.position = position ?? value
    }

    mutating func dealIntoNewStack() {
        position = deckSize - 1 - position
    }

    mutating func cut(n: Int) {
        position = (position + deckSize - n) % deckSize
    }

    mutating func deal(increment: Int) {
        position = (position * increment) % deckSize
    }

    mutating func deal(decrement: Int) {
        var p = position
        while p % decrement != 0 {
            p += deckSize
        }
        position = p / decrement
    }
}
