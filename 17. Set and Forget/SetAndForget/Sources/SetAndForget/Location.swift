
public struct Location: Hashable {
    var x: Int
    var y: Int

    public init(x: Int = 0, y: Int = 0) {
        self.x = x
        self.y = y
    }

    var up: Location {
        Location(x: x, y: y - 1)
    }

    var down: Location {
        Location(x: x, y: y + 1)
    }

    var left: Location {
        Location(x: x - 1, y: y)
    }

    var right: Location {
        Location(x: x + 1, y: y)
    }
}
