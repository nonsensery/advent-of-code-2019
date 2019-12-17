
class RepairDroid {
    private var computer: Intcomputer

    enum Movement: Int {
        case north = 1, south, west, east

        var reversed: Movement {
            switch self {
            case .north:
                return .south
            case .south:
                return .north
            case .west:
                return .east
            case .east:
                return .west
            }
        }
    }

    enum Feedback: Int {
        case blockedByWall = 0, movedToEmptySpace, movedAndFoundOxygenSystem
    }

    init(program: Intcomputer.Program) {
        self.computer = Intcomputer(program: program)
    }

    func move(_ movement: Movement) -> Feedback {
        var input: Intcomputer.Value? = movement.rawValue
        var output: Intcomputer.Value? = nil

        self.computer.input = {
            assert(input != nil)

            defer { input = nil }
            return input!
        }

        self.computer.output = {
            assert(output == nil)

            output = $0
        }

        while output == nil {
            assert(computer.isRunning)

            try! computer.tick()
        }

        return Feedback(rawValue: output!)!
    }
}
