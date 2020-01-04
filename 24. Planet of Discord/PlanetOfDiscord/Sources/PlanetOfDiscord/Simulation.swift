
struct Simulation {
    typealias State = BitCollection<Int>

    private(set) var state: State
    let width: Int
    let height: Int

    init(initialState: State, width: Int, height: Int) {
        self.state = initialState
        self.width = width
        self.height = height
    }

    mutating func step() {
        let oldState = state
        var newState = oldState

        func get(x: Int, y: Int) -> Bool {
            guard x >= 0 && x < width, y >= 0, y < height else {
                return false
            }

            return oldState[y * width + x]
        }

        func set(x: Int, y: Int, _ value: Bool) {
            assert(x >= 0 && x < width)
            assert(y >= 0 && y < height)

            newState[y * width + x] = value
        }

        (0 ..< height).forEach { y in
            (0 ..< width).forEach { x in
                let c = get(x: x, y: y)
                let u = get(x: x, y: y - 1) ? 1 : 0
                let d = get(x: x, y: y + 1) ? 1 : 0
                let l = get(x: x - 1, y: y) ? 1 : 0
                let r = get(x: x + 1, y: y) ? 1 : 0
                let surroundingBugs = u + d + l + r

                if c {
                    if surroundingBugs != 1 {
                        // die
                        set(x: x, y: y, false)
                    }
                } else {
                    if surroundingBugs == 1 || surroundingBugs == 2 {
                        // infest
                        set(x: x, y: y, true)
                    }
                }
            }
        }

        state = newState
    }

    var biodiversity: Int {
        state.storage
    }
}
