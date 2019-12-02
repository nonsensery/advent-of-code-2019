import Foundation

let program = Bundle.main.url(forResource: "gravity-assist", withExtension: "intcode")
    .flatMap({ try? Data(contentsOf: $0) })
    .flatMap({ String(data: $0, encoding: .utf8) })
    .map({ $0.trimmingCharacters(in: .whitespacesAndNewlines) })?
    .split(separator: ",")
    .map({ Int($0)! })
    ?? []

struct Computer {
    typealias MemoryValue = Int
    typealias Memory = [MemoryValue]
    typealias MemoryAddress = Memory.Index

    enum Instruction {
        case math((MemoryValue, MemoryValue) -> MemoryValue, lhs: MemoryAddress, rhs: MemoryAddress, dest: MemoryAddress)
        case halt
    }

    var memory: Memory
    private var ip: MemoryAddress

    init(memory: Memory = []) {
        self.memory = memory
        self.ip = memory.startIndex
    }

    private mutating func readNextInstruction() -> Instruction? {
        guard ip < memory.endIndex else {
            return nil
        }

        func advanceIP() -> MemoryValue {
            defer {
                ip = memory.index(after: ip)
            }

            return memory[ip]
        }

        let opcode = advanceIP()

        switch opcode {
        case 1:
            return .math(+, lhs: advanceIP(), rhs: advanceIP(), dest: advanceIP())
        case 2:
            return .math(*, lhs: advanceIP(), rhs: advanceIP(), dest: advanceIP())
        case 99:
            return .halt
        default:
            fatalError("Unexpected opcode: \(opcode)")
        }
    }

    mutating func run() {
        while let instruction = readNextInstruction() {
            switch instruction {
            case .math(let op, lhs: let lhs, rhs: let rhs, dest: let dest):
                memory[dest] = op(memory[lhs], memory[rhs])
            case .halt:
                ip = memory.endIndex
            }
        }
    }
}

func compute(noun: Int, verb: Int) -> Int {
    var computer = Computer(memory: program)

    computer.memory[1...2] = [noun, verb]
    computer.run()

    return computer.memory[0]
}

// MARK: Part 1

print(compute(noun: 12, verb: 02))
//12490719

// MARK: Part 2

let desiredOutput = 19690720

// This is based on some observed behavior of how the noun and verb affect the output.
// Not sure how to generalize it without solving the halting problem...
let noun = (0...99).first(where: { compute(noun: $0 + 1, verb: 0) > desiredOutput })!
let verb = (0...99).first(where: { compute(noun: noun, verb: $0) == desiredOutput })!

print("\(noun * 100 + verb)")
//203
