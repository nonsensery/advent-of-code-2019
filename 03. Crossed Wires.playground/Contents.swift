import Foundation

struct Movement {
    var direction: Direction
    var distance: Int

    enum Direction: Character {
        case up = "U", down = "D", right = "R", left = "L"
    }
}

struct Point: Hashable {
    var x = 0
    var y = 0

    var manhattanDistance: Int {
        return abs(x) + abs(y)
    }
}

extension Point: CustomStringConvertible {
    var description: String {
        return"(\(x), \(y))"
    }
}

extension Movement {
    init?(string: String) {
        guard let direction = string.first.flatMap({ Direction(rawValue: $0) }) else {
            return nil
        }

        guard let distance = Int(string.dropFirst()) else {
            return nil
        }

        self.init(direction: direction, distance: distance)
    }
}

let paths = Bundle.main.url(forResource: "input", withExtension: "txt")
    .flatMap({ try? Data(contentsOf: $0) })
    .flatMap({ String(data: $0, encoding: .utf8) })?
    .split(separator: "\n")
    .map { line in
        line
            .split(separator: ",")
            .map({ Movement(string: String($0))! })
            .filter({ $0.distance > 0 })
    }
    ?? []

struct Trace {
    private var cursor = Point() {
        didSet {
            points.insert(cursor)
        }
    }

    private(set) var points: Set<Point> = []

    func applying(_ movements: [Movement]) -> Self {
        var copy = self
        copy.apply(movements)
        return copy
    }

    func applying(_ movement: Movement) -> Self {
        var copy = self
        copy.apply(movement)
        return copy
    }

    mutating func apply(_ movements: [Movement]) {
        movements.forEach({ apply($0) })
    }

    mutating func apply(_ movement: Movement) {
        switch movement.direction {
        case .up:
            (0 ..< movement.distance).forEach({ _ in cursor.y += 1 })
        case .down:
            (0 ..< movement.distance).forEach({ _ in cursor.y -= 1 })
        case .left:
            (0 ..< movement.distance).forEach({ _ in cursor.x -= 1 })
        case .right:
            (0 ..< movement.distance).forEach({ _ in cursor.x += 1 })
        }
    }
}

let pointSets = paths.map({ Trace().applying($0).points })

let points1 = pointSets[0]
let points2 = pointSets[1]

let intersections = Array(points1.intersection(points2))

print(intersections.map({ $0.manhattanDistance }).min())
