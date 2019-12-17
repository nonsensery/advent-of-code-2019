
class RepairDroidSession {
    private let droid: RepairDroid
    private var droidLocation: Location
    private var environment: [Location: LocationDescription]

    enum LocationDescription {
        case open, wall, oxygenSystem
    }

    init(program: Intcomputer.Program) {
        self.droid = RepairDroid(program: program)
        droidLocation = Location()
        environment = [droidLocation: .open] // assume the droid starts in an open space
    }

    var oxygenSystemLocation: Location? {
        environment.first(where: { $0.value == .oxygenSystem })?.key
    }

    func explore() {
        [RepairDroid.Movement.north, .south, .east, .west].forEach { movement in
            let location = droidLocation.moved(movement)

            if !environment.keys.contains(location) && move(movement) {
                explore()
                move(movement.reversed)
            }
        }
    }

    @discardableResult
    private func move(_ movement: RepairDroid.Movement) -> Bool {
        let nextLocation = droidLocation.moved(movement)
        let moved: Bool

        switch droid.move(movement) {
        case .blockedByWall:
            environment[nextLocation] = .wall
            moved = false
        case .movedToEmptySpace:
            environment[nextLocation] = .open
            moved = true
        case .movedAndFoundOxygenSystem:
            environment[nextLocation] = .oxygenSystem
            moved = true
        }

        if moved {
            droidLocation = nextLocation
        }

        return moved
    }

    func mapPathDistances(from origin: Location = Location()) -> [Location: Int] {
        var distances: [Location: Int] = [:]

        mapPathDistances(from: origin, startingDistance: 0, distances: &distances)

        return distances
    }

    private func mapPathDistances(from location: Location, startingDistance distance: Int, distances: inout [Location: Int]) {
        guard distances[location] == nil else {
            return
        }

        assert(environment[location] != nil)

        if environment[location] != .wall {
            distances[location] = distance

            mapPathDistances(from: location.moved(.north), startingDistance: distance + 1, distances: &distances)
            mapPathDistances(from: location.moved(.south), startingDistance: distance + 1, distances: &distances)
            mapPathDistances(from: location.moved(.west), startingDistance: distance + 1, distances: &distances)
            mapPathDistances(from: location.moved(.east), startingDistance: distance + 1, distances: &distances)
        }
    }

    func drawEnvironment() -> String {
        let xs = environment.keys.map({ $0.x })
        let ys = environment.keys.map({ $0.y })

        let minX = xs.min() ?? 0
        let maxX = xs.max() ?? 0
        let minY = ys.min() ?? 0
        let maxY = ys.max() ?? 0

        // Pad out to minimum size so that you can tell what you're looking at:
        let padX = max(0, 5 - (maxX - minX)) / 2
        let padY = max(0, 5 - (maxY - minY)) / 2

        return
            ((minY - padY) ... (maxY + padY)).map { y in
                ((minX - padX) ... (maxX + padX)).map { x in
                    let location = Location(x: x, y: y)

                    if location == droidLocation {
                        return "🤖"
                    }

                    switch environment[location] {
                    case nil:
                        return "❔"
                    case .wall:
                        return "⬛️"
                    case .open:
                        return "▫️"
                    case .oxygenSystem:
                        return "🅾️"
                    }
                }
                .joined()
            }
            .joined(separator: "\n")
    }
}

private extension Location {
    mutating func move(_ movement: RepairDroid.Movement) {
        switch movement {
        case .north:
            self.y -= 1
        case .south:
            self.y += 1
        case .west:
            self.x -= 1
        case .east:
            self.x += 1
        }
    }

    func moved(_ movement: RepairDroid.Movement) -> Self {
        var copy = self
        copy.move(movement)
        return copy
    }
}
