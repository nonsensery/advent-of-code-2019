
class ArcadeCabinet {
    private let program: Intcomputer.Program

    private(set) var credits = 0

    private let segmentedDisplayLocation = Location(x: -1, y: 0)
    private var segmentedDisplayValue = 0

    private let screenSize: (width: Int, height: Int)
    private var screenTiles: [Tile]

    var joystickPosition: JoystickPosition = .neutral

    private enum Buffer<Value> {
        case empty
        case one(Value)
        case two(Value, Value)
        case full(Value, Value, Value)

        mutating func append(_ value: Value) {
            switch self {
            case .empty:
                self = .one(value)
            case .one(let a):
                self = .two(a, value)
            case .two(let a, let b):
                self = .full(a, b, value)
            case .full:
                fatalError("Buffer overflow")
            }
        }
    }

    enum Tile: Int {
        case empty = 0, wall, block, paddle, ball

        var glyph: Character {
            switch self {
            case .empty:
                return "⬜️"
            case .wall:
                return "⬛️"
            case .block:
                return "💟"
            case .paddle:
                return "➖"
            case .ball:
                return "🔴"
            }
        }
    }

    enum JoystickPosition: Int {
        case left = -1, neutral = 0, right = 1
    }

    init(screenSize: (width: Int, height: Int) = (38, 20), program: Intcomputer.Program) {
        self.screenSize = screenSize
        self.screenTiles = Array(repeating: .empty, count: screenSize.height * screenSize.width)
        self.program = program
    }

    func drawSegmentedDisplay() -> String {
        return String(segmentedDisplayValue)
    }

    func drawScreen() -> String {
        (0..<screenSize.height).map { y in
            String(
                (0..<screenSize.width).map { x in
                    screenTiles[y * screenSize.width + x].glyph
                }
            )
        }
        .joined(separator: "\n")
    }

    func insertCoins() {
        credits += 1
    }

    func play(_ play: @escaping (String) -> Void = { _ in }) throws {
        var program = self.program

        if credits > 0 {
            credits -= 1
            program[0] = 2
        }

        var computer = Intcomputer(program: program)

        computer.input = Input {
            play(self.drawScreen())
            return self.joystickPosition.rawValue
        }

        var outputBuffer: Buffer<Intcomputer.Value> = .empty

        computer.output = Output {
            outputBuffer.append($0)

            if case .full(let x, let y, let value) = outputBuffer {
                outputBuffer = .empty

                let location = Location(x: x, y: y)

                if location == self.segmentedDisplayLocation {
                    self.segmentedDisplayValue = value
                } else {
                    self.screenTiles[y * self.screenSize.width + x] = Tile(rawValue: value)!
                }
            }
        }

        while computer.isRunning {
            try computer.tick()
        }
    }

    private struct Input: Intcomputer.Input {
        let readBody: () -> Intcomputer.Value?

        init(read readBody: @escaping () -> Intcomputer.Value?) {
            self.readBody = readBody
        }

        mutating func read() -> Intcomputer.Value? {
            readBody()
        }
    }

    private struct Output: Intcomputer.Output {
        let writeBody: (Intcomputer.Value) -> Void

        init(write writeBody: @escaping (Intcomputer.Value) -> Void) {
            self.writeBody = writeBody
        }

        func write(_ value: Intcomputer.Value) {
            writeBody(value)
        }
    }
}
