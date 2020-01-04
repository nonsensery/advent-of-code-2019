import XCTest
@testable import PlanetOfDiscord

final class PlanetOfDiscordTests: XCTestCase {
    func testExample1() {
        var sim: Simulation =
            """
            ....#
            #..#.
            #..##
            ..#..
            #....
            """

        XCTAssertEqual(
            sim.description,
            """
            ....#
            #..#.
            #..##
            ..#..
            #....
            """
        )

        sim.step()

        XCTAssertEqual(
            sim.description,
            """
            #..#.
            ####.
            ###.#
            ##.##
            .##..
            """
        )

        sim.step()

        XCTAssertEqual(
            sim.description,
            """
            #####
            ....#
            ....#
            ...#.
            #.###
            """
        )

        sim.step()

        XCTAssertEqual(
            sim.description,
            """
            #....
            ####.
            ...##
            #.##.
            .##.#
            """
        )

        sim.step()

        XCTAssertEqual(
            sim.description,
            """
            ####.
            ....#
            ##..#
            .....
            ##...
            """
        )
    }

    func testExample2() {
        let sim: Simulation =
            """
            .....
            .....
            .....
            #....
            .#...
            """

        XCTAssertEqual(sim.biodiversity, 2129920)
    }

    func testPart1() {
        let result = computeCyclicalBiodiversity(Simulation(stringLiteral: inputData))

        XCTAssertEqual(result, 32513278)
    }

    func testExample3() {
        var sim: Simulation2 =
            """
            ....#
            #..#.
            #.?##
            ..#..
            #....
            """

        XCTAssertEqual(
            sim.description,
            """
            Depth 0:
            ....#
            #..#.
            #.?##
            ..#..
            #....
            """
        )

        (1...10).forEach { _ in
            sim.step()
        }

        XCTAssertEqual(
            sim.description,
            """
            Depth -5:
            ..#..
            .#.#.
            ..?.#
            .#.#.
            ..#..

            Depth -4:
            ...#.
            ...##
            ..?..
            ...##
            ...#.

            Depth -3:
            #.#..
            .#...
            ..?..
            .#...
            #.#..

            Depth -2:
            .#.##
            ....#
            ..?.#
            ...##
            .###.

            Depth -1:
            #..##
            ...##
            ..?..
            ...#.
            .####

            Depth 0:
            .#...
            .#.##
            .#?..
            .....
            .....

            Depth 1:
            .##..
            #..##
            ..?.#
            ##.##
            #####

            Depth 2:
            ###..
            ##.#.
            #.?..
            .#.##
            #.#..

            Depth 3:
            ..###
            .....
            #.?..
            #....
            #...#

            Depth 4:
            .###.
            #..#.
            #.?..
            ##.#.
            .....

            Depth 5:
            ####.
            #..#.
            #.?#.
            ####.
            .....
            """
        )

        XCTAssertEqual(sim.population, 99)
    }

    func testPart2() {
        let result = computePopulation(Simulation2(stringLiteral: inputData), after: 200)

        XCTAssertEqual(result, 1912)
    }

    static var allTests = [
        ("testExample1", testExample1),
    ]
}

extension Simulation: ExpressibleByStringLiteral, CustomStringConvertible {
    public init(stringLiteral s: String) {
        let width = s.firstIndex(of: "\n").map({ s.distance(from: s.startIndex, to: $0) }) ?? 1
        let height = s.count / width

        var state: State = 0

        zip(0..., s.lazy.filter({ $0 != "\n" })).forEach {
            let (i, c) = $0

            state[i] = (c == "#")
        }

        self.init(initialState: state, width: width, height: height)
    }

    public var description: String {
        (0 ..< height).map { y in
            (0 ..< width).map { x in
                state[y * width + x] ? "#" : "."
            }
            .joined()
        }
        .joined(separator: "\n")
    }
}

extension Simulation2: ExpressibleByStringLiteral, CustomStringConvertible {
    public init(stringLiteral s: String) {
        let width = s.firstIndex(of: "\n").map({ s.distance(from: s.startIndex, to: $0) }) ?? 1
        let height = s.count / width

        var layer: Layer = 0

        zip(0..., s.lazy.filter({ $0 != "\n" })).forEach {
            let (i, c) = $0

            layer[i] = (c == "#")
        }

        self.init(initialState: layer, width: width, height: height)
    }

    public var description: String {
        state.keys.sorted().map { z in
            "Depth \(z):\n"
            +
            (0 ..< height).map { y in
                (0 ..< width).map { x in
                    if x == width / 2 && y == height / 2 {
                        return "?"
                    } else if state[z]![y * width + x] {
                        return "#"
                    } else {
                        return "."
                    }
                }
                .joined()
            }
            .joined(separator: "\n")
        }
        .joined(separator: "\n\n")
    }
}
