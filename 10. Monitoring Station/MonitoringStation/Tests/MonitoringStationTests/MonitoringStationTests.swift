import XCTest
import MonitoringStation

final class MonitoringStationTests: XCTestCase {
    func testExample() {
        let result = findStationLocation(
            """
            .#..#
            .....
            #####
            ....#
            ...##
            """
        )

        XCTAssertEqual(result?.station, Location(3, 4))
        XCTAssertEqual(result?.detected, 8)
    }

    func testSample1() {
        let result = findStationLocation(
            """
            ......#.#.
            #..#.#....
            ..#######.
            .#.#.###..
            .#..#.....
            ..#....#.#
            #..#....#.
            .##.#..###
            ##...#..#.
            .#....####
            """
        )

        XCTAssertEqual(result?.station, Location(5, 8))
        XCTAssertEqual(result?.detected, 33)
    }

    func testSample2() {
        let result = findStationLocation(
            """
            #.#...#.#.
            .###....#.
            .#....#...
            ##.#.#.#.#
            ....#.#.#.
            .##..###.#
            ..#...##..
            ..##....##
            ......#...
            .####.###.
            """
        )

        XCTAssertEqual(result?.station, Location(1, 2))
        XCTAssertEqual(result?.detected, 35)
    }

    func testSample3() {
        let result = findStationLocation(
            """
            .#..#..###
            ####.###.#
            ....###.#.
            ..###.##.#
            ##.##.#.#.
            ....###..#
            ..#.#..#.#
            #..#.#.###
            .##...##.#
            .....#.#..
            """
        )

        XCTAssertEqual(result?.station, Location(6, 3))
        XCTAssertEqual(result?.detected, 41)
    }

    func testSample4() {
        let result = findStationLocation(
            """
            .#..##.###...#######
            ##.############..##.
            .#.######.########.#
            .###.#######.####.#.
            #####.##.#.##.###.##
            ..#####..#.#########
            ####################
            #.####....###.#.#.##
            ##.#################
            #####.##.###..####..
            ..######..##.#######
            ####.##.####...##..#
            .#####..#.######.###
            ##...#.##########...
            #.##########.#######
            .####.#.###.###.#.##
            ....##.##.###..#####
            .#.#.###########.###
            #.#.#.#####.####.###
            ###.##.####.##.#..##
            """
        )

        XCTAssertEqual(result?.station, Location(11, 13))
        XCTAssertEqual(result?.detected, 210)
    }

    func testPart1MyInput() {
        let result = findStationLocation(
            """
            #..#.#.#.######..#.#...##
            ##.#..#.#..##.#..######.#
            .#.##.#..##..#.#.####.#..
            .#..##.#.#..#.#...#...#.#
            #...###.##.##..##...#..#.
            ##..#.#.#.###...#.##..#.#
            ###.###.#.##.##....#####.
            .#####.#.#...#..#####..#.
            .#.##...#.#...#####.##...
            ######.#..##.#..#.#.#....
            ###.##.#######....##.#..#
            .####.##..#.##.#.#.##...#
            ##...##.######..##..#.###
            ...###...#..#...#.###..#.
            .#####...##..#..#####.###
            .#####..#.#######.###.##.
            #...###.####.##.##.#.##.#
            .#.#.#.#.#.##.#..#.#..###
            ##.#.####.###....###..##.
            #..##.#....#..#..#.#..#.#
            ##..#..#...#..##..####..#
            ....#.....##..#.##.#...##
            .##..#.#..##..##.#..##..#
            .##..#####....#####.#.#.#
            #..#..#..##...#..#.#.#.##
            """
        )

        XCTAssertEqual(result?.station, Location(11, 19))
        XCTAssertEqual(result?.detected, 253)
    }

    func testPart2Sample1() {
        let asteroids = parseAsteroids(
            """
            .#..##.###...#######
            ##.############..##.
            .#.######.########.#
            .###.#######.####.#.
            #####.##.#.##.###.##
            ..#####..#.#########
            ####################
            #.####....###.#.#.##
            ##.#################
            #####.##.###..####..
            ..######..##.#######
            ####.##.####...##..#
            .#####..#.######.###
            ##...#.##########...
            #.##########.#######
            .####.#.###.###.#.##
            ....##.##.###..#####
            .#.#.###########.###
            #.#.#.#####.####.###
            ###.##.####.##.#..##
            """
        )

        guard let station = findStationLocation(asteroids)?.station else {
            XCTFail()
            return
        }

        let result = asteroids.sortedByVaporizationOrder(from: station)

        XCTAssertEqual(result[199], Location(8, 2))
    }

    func testPart2MyInput() {
        let asteroids = parseAsteroids(
            """
            #..#.#.#.######..#.#...##
            ##.#..#.#..##.#..######.#
            .#.##.#..##..#.#.####.#..
            .#..##.#.#..#.#...#...#.#
            #...###.##.##..##...#..#.
            ##..#.#.#.###...#.##..#.#
            ###.###.#.##.##....#####.
            .#####.#.#...#..#####..#.
            .#.##...#.#...#####.##...
            ######.#..##.#..#.#.#....
            ###.##.#######....##.#..#
            .####.##..#.##.#.#.##...#
            ##...##.######..##..#.###
            ...###...#..#...#.###..#.
            .#####...##..#..#####.###
            .#####..#.#######.###.##.
            #...###.####.##.##.#.##.#
            .#.#.#.#.#.##.#..#.#..###
            ##.#.####.###....###..##.
            #..##.#....#..#..#.#..#.#
            ##..#..#...#..##..####..#
            ....#.....##..#.##.#...##
            .##..#.#..##..##.#..##..#
            .##..#####....#####.#.#.#
            #..#..#..##...#..#.#.#.##
            """
        )

        guard let station = findStationLocation(asteroids)?.station else {
            XCTFail()
            return
        }

        let result = asteroids.sortedByVaporizationOrder(from: station)

        XCTAssertEqual(result[199], Location(8, 15))
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

private func parseAsteroids(_ input: String) -> [Location] {
    parseAsteroids(
        input
            .split(separator: "\n")
            .map { line in
                line.map {
                    $0 == "#"
                }
            }
    )
}

private func parseAsteroids(_ data: [[Bool]]) -> [Location] {
    zip(data, data.indices)
        .reduce(into: []) { result, rowAndY in
            let (row, y) = rowAndY

            zip(row, row.indices).forEach {
                let (hasAsteroid, x) = $0

                if hasAsteroid {
                    result.append(Location(x, y))
                }
            }
        }
}

private func findStationLocation(_ input: String) -> (station: Location, detected: Int)? {
    findStationLocation(parseAsteroids(input))
}
