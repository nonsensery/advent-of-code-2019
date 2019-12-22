import struct Foundation.TimeInterval

class ASCIIComputer {
    typealias Program = Intcomputer.Program

    private var computer: Intcomputer

    var inputLine: () -> String? = {
        print("> ", terminator: "")
        return readLine()
    }

    var outputLine: (String) -> Void = {
        print("< \($0)")
    }

    var outputNonASCII: (Int) -> Void = {
        print("<< \($0)")
    }

    init(program: Program) {
        self.computer = Intcomputer(program: program)

        var inputBuffer: Substring = ""
        var outputBuffer = ""

        computer.input = {
            if inputBuffer.isEmpty, let line = self.inputLine() {
                inputBuffer.append(contentsOf: line)
                inputBuffer.append("\n")
            }

            return inputBuffer.popFirst()?.asciiValue.map(Int.init)
        }

        computer.output = {
            guard let ascii = UInt8(exactly: $0), ascii < 0x80 else {
                self.outputNonASCII($0)
                return
            }

            let char = Character(Unicode.Scalar(ascii))

            if char == "\n" {
                let line = outputBuffer
                outputBuffer = ""

                self.outputLine(line)
            } else {
                outputBuffer.append(char)
            }
        }
    }

    var isRunning: Bool {
        computer.isRunning
    }

    func run(timeout: TimeInterval? = nil) throws {
        try computer.run(timeout: timeout)
    }

    func tick() throws {
        try computer.tick()
    }
}
