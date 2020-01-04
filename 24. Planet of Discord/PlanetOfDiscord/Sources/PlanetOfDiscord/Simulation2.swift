
struct Simulation2 {
    typealias Layer = BitCollection<Int>
    typealias State = [Int: Layer]

    private(set) var state: State
    let width: Int
    let height: Int

    init(initialState: Layer, width: Int, height: Int) {
        assert(width % 2 == 1)
        assert(height % 2 == 1)
        assert(initialState[height / 2 * width + width / 2] == false)

        self.state = [0: initialState]
        self.width = width
        self.height = height
    }

    mutating func step() {
        let oldState = state
        var newState = oldState

        let minX = 0, maxX = width - 1, midX = width/2
        let minY = 0, maxY = height - 1, midY = height/2
        let minZ = (oldState.keys.min() ?? 0) - 1, maxZ = (oldState.keys.max() ?? 0) + 1

        let xs = minX ..< width
        let ys = minY ..< height
        let zs = minZ ... maxZ

        func get(_ location: Location) -> Bool {
            assert(xs ~= location.x)
            assert(ys ~= location.y)

            return oldState[location.z]?[location.y * width + location.x] ?? false
        }

        func set(_ location: Location, _ value: Bool) {
            assert(xs ~= location.x)
            assert(ys ~= location.y)

            newState[location.z, default: Layer()][location.y * width + location.x] = value
        }

        func surroundingLocations(_ location: Location) -> [Location] {
            let center = Location(x: midX, y: midY, z: location.z)
            var result: [Location] = []

            // north

            let north = location.north

            if north.y < minY {
                result.append(center.north.out)
            } else if north == center {
                let y = maxY
                let z = north.in.z
                result.append(contentsOf: xs.map({ x in Location(x: x, y: y, z: z) }))
            } else {
                result.append(north)
            }

            // south

            let south = location.south

            if south.y > maxY {
                result.append(center.south.out)
            } else if south == center {
                let y = minY
                let z = south.in.z
                result.append(contentsOf: xs.map({ x in Location(x: x, y: y, z: z) }))
            } else {
                result.append(south)
            }

            // west

            let west = location.west

            if west.x < minX {
                result.append(center.west.out)
            } else if west == center {
                let x = maxX
                let z = west.in.z
                result.append(contentsOf: ys.map({ y in Location(x: x, y: y, z: z) }))
            } else {
                result.append(west)
            }

            // east

            let east = location.east

            if east.x > maxX {
                result.append(center.east.out)
            } else if east == center {
                let x = minX
                let z = east.in.z
                result.append(contentsOf: ys.map({ y in Location(x: x, y: y, z: z) }))
            } else {
                result.append(east)
            }

            return result
        }

        zs.forEach { z in
            ys.forEach { y in
                xs.forEach { x in
                    let location = Location(x: x, y: y, z: z)

                    guard x != midX || y != midY else {
                        return
                    }

                    let c = get(location)
                    let surroundingBugs = surroundingLocations(location).map({ get($0) ? 1 : 0 }).reduce(0, +)

                    if c {
                        if surroundingBugs != 1 {
                            // die
                            set(location, false)
                        }
                    } else {
                        if surroundingBugs == 1 || surroundingBugs == 2 {
                            // infest
                            set(location, true)
                        }
                    }
                }
            }
        }

        state = newState
    }

    var population: Int {
        state
            .flatMap {
                $0.value.map({ $0 ? 1 : 0 })
            }
            .reduce(0, +)
    }
}
