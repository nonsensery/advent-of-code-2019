import Foundation

// MARK: - Types

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

struct Segment {
    let start: Point
    let end: Point
    let length: Int

    private let xRange: ClosedRange<Int>
    private let yRange: ClosedRange<Int>

    init(origin: Point, movement: Movement) {
        switch movement.direction {
        case .up:
            start = Point(x: origin.x, y: origin.y + 1)
            end = Point(x: origin.x, y: origin.y + movement.distance)
        case .down:
            start = Point(x: origin.x, y: origin.y - 1)
            end = Point(x: origin.x, y: origin.y - movement.distance)
        case .left:
            start = Point(x: origin.x - 1, y: origin.y)
            end = Point(x: origin.x - movement.distance, y: origin.y)
        case .right:
            start = Point(x: origin.x + 1, y: origin.y)
            end = Point(x: origin.x + movement.distance, y: origin.y)
        }

        xRange = min(start.x, end.x) ... max(start.x, end.x)
        yRange = min(start.y, end.y) ... max(start.y, end.y)
        length = movement.distance
    }

    private func contains(_ point: Point) -> Bool {
        xRange.contains(point.x) && yRange.contains(point.y)
    }

    func firstIntersection(_ segment: Segment) -> Point? {
        guard let x = xRange.intersection(segment.xRange)?.first, let y = yRange.intersection(segment.yRange)?.first else {
            return nil
        }

        return Point(x: x, y: y)
    }

    func distance(to point: Point) -> Int? {
        guard contains(point) else {
            return nil
        }

        return abs(start.x - point.x) + abs(start.y - point.y) + 1
    }
}

struct Path {
    let segments: [Segment]

    init(movements: [Movement]) {
        segments = movements.reduce(into: []) { result, movement in
            result.append(Segment(origin: result.last?.end ?? Point(), movement: movement))
        }
    }
}

extension ClosedRange where Bound: Comparable {
    func intersection(_ range: Self) -> Self? {
        guard upperBound >= range.lowerBound && lowerBound <= range.upperBound else {
            return nil
        }

        return Swift.max(lowerBound, range.lowerBound) ... Swift.min(upperBound, range.upperBound)
    }
}

// MARK: - Parsing

extension Path {
    init?<S: StringProtocol>(string: S) {
        let movements = string
            .split(separator: ",")
            .compactMap({ Movement(string: $0) })

        self.init(movements: movements)
    }
}

extension Movement {
    init?<S: StringProtocol>(string: S) {
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
    .compactMap({ Path(string: $0) })
    ?? []

let path1 = paths[0]
let path2 = paths[1]

// MARK: - Part 1

func minManhattanDistanceToIntersection(_ path1: Path, _ path2: Path) -> Int? {
    let segments1 = path1.segments
    let segments2 = path2.segments

    var minDistance: Int?

    for s1 in segments1 {
        for s2 in segments2 {
            if let p = s1.firstIntersection(s2) {
                let distance = p.manhattanDistance

                if let m = minDistance, m <= distance {
                    // no op
                } else {
                    minDistance = distance
                }
            }
        }

    }

    return minDistance
}

if let min = minManhattanDistanceToIntersection(path1, path2) {
    print(min) // => 1431
} else {
    print("no intersenctions found")
}

// MARK: - Part 2

func minPathDistanceToIntersection(_ path1: Path, _ path2: Path) -> Int? {
    let segments1 = path1.segments
    let segments2 = path2.segments

    var d1 = 0
    var d2 = 0

    var minDistance: Int?

    outer: for s1 in segments1 {
        defer { d1 += s1.length }
        d2 = 0

        for s2 in segments2 {
            defer { d2 += s2.length }

            if let p = s1.firstIntersection(s2), let sd1 = s1.distance(to: p), let sd2 = s2.distance(to: p) {
                let distance = d1 + sd1 + d2 + sd2

                if let m = minDistance, m <= distance {
                    // no op
                } else {
                    minDistance = distance
                }

                // Short circuit the inner for loop because there won't be any intersections that are closer than this one.
                continue outer
            }
        }
    }

    return minDistance
}

if let min = minPathDistanceToIntersection(path1, path2) {
    print(min) // => 48012
} else {
    print("no intersenctions found")
}
