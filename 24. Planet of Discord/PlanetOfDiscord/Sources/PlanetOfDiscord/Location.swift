
struct Location: Hashable {
    var x: Int
    var y: Int
    var z: Int

    init(x: Int = 0, y: Int = 0, z: Int = 0) {
        self.x = x
        self.y = y
        self.z = z
    }

    var north: Location {
        Location(x: x, y: y - 1, z: z)
    }

    var south: Location {
        Location(x: x, y: y + 1, z: z)
    }

    var west: Location {
        Location(x: x - 1, y: y, z: z)
    }

    var east: Location {
        Location(x: x + 1, y: y, z: z)
    }

    var `in`: Location {
        Location(x: x, y: y, z: z + 1)
    }

    var out: Location {
        Location(x: x, y: y, z: z - 1)
    }
}
