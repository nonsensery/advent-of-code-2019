
public struct IntcomputerPaintController: PaintOperation.Controller {
    private var computer: Intcomputer

    public init(program: Intcomputer.Program) {
        self.computer = Intcomputer(program: program)
    }

    public mutating func next(_ color: PaintOperation.Color) -> (PaintOperation.Color, PaintOperation.TurnDirection)? {
        let io = IO(color)

        computer.input = io
        computer.output = io

        repeat { try! computer.tick() } while computer.isRunning && io.result == nil

        return io.result
    }

    private class IO: Intcomputer.Input, Intcomputer.Output {
        private let inputRawColor: Intcomputer.Value
        private var outputRawColor: Intcomputer.Value?
        private var outputRawTurnDirection: Intcomputer.Value?

        init(_ color: PaintOperation.Color) {
            inputRawColor = color.rawValue
        }

        var result: (PaintOperation.Color, PaintOperation.TurnDirection)? {
            guard let outputColor = outputRawColor.flatMap(PaintOperation.Color.init) else {
                return nil
            }

            guard let outputTurnDirection = outputRawTurnDirection.flatMap(PaintOperation.TurnDirection.init) else {
                return nil
            }

            return (outputColor, outputTurnDirection)
        }

        func read() -> Intcomputer.Value? {
            inputRawColor
        }

        func write(_ value: Intcomputer.Value) {
            if outputRawColor == nil {
                outputRawColor = value
            } else if outputRawTurnDirection == nil {
                outputRawTurnDirection = value
            } else {
                fatalError("illegal state")
            }
        }
    }
}
