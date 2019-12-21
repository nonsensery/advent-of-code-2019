
func countPullingLocations(program: Intcomputer.Program, width: Int, height: Int) -> Int {
    let data = scanRegion(program: program, x0: 0, y0: 0, width: width, height: height)

    return data.lazy.filter({ $0.value }).count
}

func scanRegion(program: Intcomputer.Program, x0: Int = 0, y0: Int = 0, width: Int, height: Int) -> [Location: Bool] {
    var result: [Location: Bool] = [:]

    testRegion(xs: x0 ..< (x0 + width), ys: y0 ..< (y0 + height), program: program) { x, y, pulls in
        result[Location(x: x, y: y)] = pulls
    }

    return result
}

func drawRegion(_ data: [Location: Bool]) -> String {
    let xRange = (data.keys.lazy.map({ $0.x }).min() ?? 0) ... (data.keys.lazy.map({ $0.x }).max() ?? 0)
    let yRange = (data.keys.lazy.map({ $0.y }).min() ?? 0) ... (data.keys.lazy.map({ $0.y }).max() ?? 0)

    return
        yRange.map { y in
            xRange.map { x in
                data[Location(x: x, y: y), default: false] ? "#" : "."
            }
            .joined()
        }
        .joined(separator: "\n")
}

func findRegion(program: Intcomputer.Program, minWidth w: Int, minHeight h: Int) -> Location? {
    var upperBound = Location(x: w + 1, y: 0)

    while !testLocation(x: upperBound.x, y: upperBound.y, program: program) {
        upperBound.y += 1
    }

    let lockX = upperBound.y > upperBound.x // lock X or Y depending on the general trend of the edge
    var lowerBound = upperBound

    while !testLocation(x: upperBound.x - w, y: upperBound.y + h, program: program) {
        lowerBound = upperBound
        upperBound = findCorner(x: upperBound.x * 2, y: upperBound.y * 2, program: program, lockX: lockX)
    }

    var done: Bool {
        (lockX ? (lowerBound.x ..< upperBound.x) : (lowerBound.y ..< upperBound.y)).count <= 1
    }

    while !done {
        let mid = findCorner(x: lowerBound.x + (upperBound.x - lowerBound.x) / 2,
                             y: lowerBound.y + (upperBound.y - lowerBound.y) / 2,
                             program: program,
                             lockX: lockX)

        if testLocation(x: mid.x - (w - 1), y: mid.y + (h - 1), program: program) {
            upperBound.x = mid.x
            upperBound.y = mid.y
        } else {
            lowerBound.x = mid.x
            lowerBound.y = mid.y
        }
    }

    return Location(x: upperBound.x - (w - 1), y: upperBound.y)
}

private func findCorner(x: Int, y: Int, program: Intcomputer.Program, lockX: Bool) -> Location {
    var x = x
    var y = y

    if lockX {
        while testLocation(x: x, y: y - 1, program: program) {
            y -= 1
        }

        while !testLocation(x: x, y: y, program: program) {
            y += 1
        }
    } else {
        while testLocation(x: x + 1, y: y, program: program) {
            x += 1
        }

        while !testLocation(x: x, y: y, program: program) {
            x -= 1
        }
    }

    return Location(x: x, y: y)
}

private func testRegion(xs: Range<Int>, ys: Range<Int>, program: Intcomputer.Program, yield: @escaping (_ x: Int, _ y: Int, _ pulls: Bool) -> Void) {
    ys.forEach { y in
        xs.forEach { x in
            testLocation(x: x, y: y, program: program, yield: { yield(x, y, $0) })
        }
    }
}

private func testLocation(x: Int, y: Int, program: Intcomputer.Program) -> Bool {
    var result = false
    testLocation(x: x, y: y, program: program, yield: { result = $0 })
    return result
}

private func testLocation(x: Int, y: Int, program: Intcomputer.Program, yield: @escaping (_ pulls: Bool) -> Void) {
    guard x >= 0 && y >= 0 else {
        yield(false)
        return
    }

    var computer = Intcomputer(program: program)
    var input = [x, y]

    computer.input = {
        input.removeFirst()
    }

    computer.output = {
        yield($0 == 1)
    }

    while computer.isRunning {
        try! computer.tick()
    }
}
