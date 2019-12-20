
class ASCII {
    private let program: Intcomputer.Program

    enum Structure {
        case open, scaffold
    }

    enum Orientation {
        case up, down, left, right
    }

    init(program: Intcomputer.Program) {
        self.program = program
    }

    struct CameraData {
        var scaffoldingLocations: Set<Location> = []
        var vacuumRobotLocation: Location
        var vacuumRobotOrientation: Orientation
    }

    func queryCameras() -> CameraData {
        var computer = Intcomputer(program: program)
        var result = CameraData(scaffoldingLocations: [], vacuumRobotLocation: Location(), vacuumRobotOrientation: .up)
        var location = Location()
        var debug = ""

        computer.output = {
            debug.append(Character(Unicode.Scalar(UInt8($0))))

            switch Character(Unicode.Scalar(UInt8($0))) {
            case "#":
                result.scaffoldingLocations.insert(location)
            case ".":
                break
            case "\n":
                location.y += 1
                location.x = -1
            case "^":
                result.scaffoldingLocations.insert(location)
                result.vacuumRobotLocation = location
                result.vacuumRobotOrientation = .up
            case "v":
                result.scaffoldingLocations.insert(location)
                result.vacuumRobotLocation = location
                result.vacuumRobotOrientation = .down
            case "<":
                result.scaffoldingLocations.insert(location)
                result.vacuumRobotLocation = location
                result.vacuumRobotOrientation = .left
            case ">":
                result.scaffoldingLocations.insert(location)
                result.vacuumRobotLocation = location
                result.vacuumRobotOrientation = .right
            default:
                fatalError("Unexpected output: \($0)")
            }

            location.x += 1
        }

        while computer.isRunning {
            try! computer.tick()
        }

        print(debug)

        return result
    }

    enum Instruction: ExpressibleByStringLiteral, ExpressibleByIntegerLiteral {
        case turnLeft, turnRight, moveForward(Int)

        var rawValue: String {
            switch self {
            case .turnLeft:
                return "L"
            case .turnRight:
                return "R"
            case .moveForward(let distance):
                return String(distance)
            }
        }

        init(stringLiteral: String) {
            switch stringLiteral {
            case "L":
                self = .turnLeft
            case "R":
                self = .turnRight
            default:
                fatalError("Invalid string literal: \(stringLiteral)")
            }
        }

        init(integerLiteral: Int) {
            self = .moveForward(integerLiteral)
        }
    }

    enum Function: String, ExpressibleByStringLiteral {
        case a = "A", b = "B", c = "C"

        init(stringLiteral: String) {
            self.init(rawValue: stringLiteral)!
        }
    }

    func moveVacuumRobot(routine: [Function], definitions: [Function: [Instruction]], debug: Bool = false) {
        var program = self.program

        // Wake up the bot:
        program[0] = 2

        var computer = Intcomputer(program: program)

        var input = ArraySlice(
            [
                routine.map({ $0.rawValue }),
                definitions[.a, default: []].map({ $0.rawValue }),
                definitions[.b, default: []].map({ $0.rawValue }),
                definitions[.c, default: []].map({ $0.rawValue }),
                [debug ? "y" : "n"],
                [],
            ]
            .map {
                $0.joined(separator: ",")
            }
            .joined(separator: "\n")
            .map {
                Int($0.asciiValue!)
            }
        )

        computer.input = {
            input.popFirst()
        }

        var outputBuffer = ""

        computer.output = {
            if $0 == 10 {
                print(outputBuffer)
                outputBuffer = ""
            } else if let asciiValue = UInt8(exactly: $0) {
                outputBuffer.append(Character(Unicode.Scalar(asciiValue)))
            } else {
                print("result: \($0)")
            }
        }

        while computer.isRunning {
            try! computer.tick()
        }
    }
}
