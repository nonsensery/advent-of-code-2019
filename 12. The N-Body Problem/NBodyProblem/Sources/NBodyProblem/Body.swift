
class Vector: Equatable {
    private(set) var position: Int
    fileprivate(set) var velocity: Int

    init(position: Int = 0, velocity: Int = 0) {
        self.position = position
        self.velocity = velocity
    }

    func move() {
        position += velocity
    }

    var potentialEnergy: Int {
        abs(position)
    }

    var kineticEnergy: Int {
        abs(velocity)
    }

    static func == (lhs: Vector, rhs: Vector) -> Bool {
        lhs.position == rhs.position && lhs.velocity == rhs.velocity
    }
}

class Body: Equatable {
    private(set) var x: Vector
    private(set) var y: Vector
    private(set) var z: Vector

    init(x: Vector = Vector(), y: Vector = Vector(), z: Vector = Vector()) {
        self.x = x
        self.y = y
        self.z = z
    }

    func move() {
        x.move()
        y.move()
        z.move()
    }

    var potentialEnergy: Int {
        x.potentialEnergy + y.potentialEnergy + z.potentialEnergy
    }

    var kineticEnergy: Int {
        x.kineticEnergy + y.kineticEnergy + z.kineticEnergy
    }

    var totalEnergy: Int {
        potentialEnergy * kineticEnergy
    }

    static func == (lhs: Body, rhs: Body) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }
}

func applyGravity(_ a: Body, _ b: Body) {
    applyGravity(a.x, b.x)
    applyGravity(a.y, b.y)
    applyGravity(a.z, b.z)
}

func applyGravity(_ a: Vector, _ b: Vector) {
    if a.position < b.position {
        a.velocity += 1
        b.velocity -= 1
    } else if a.position > b.position {
        a.velocity -= 1
        b.velocity += 1
    }
}
