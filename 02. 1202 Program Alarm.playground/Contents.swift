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
    typealias Pointer = Memory.Index

    enum Instruction {
        case math((MemoryValue, MemoryValue) -> MemoryValue, lhs: Pointer, rhs: Pointer, dest: Pointer)
        case halt
    }

    var memory: Memory
    private var pc: Pointer

    init(memory: Memory = []) {
        self.memory = memory
        self.pc = memory.startIndex
    }

    private mutating func readNextInstruction() -> Instruction? {
        guard pc < memory.endIndex else {
            return nil
        }

        func advancePC() -> MemoryValue {
            defer {
                pc = memory.index(after: pc)
            }

            return memory[pc]
        }

        let opcode = advancePC()

        switch opcode {
        case 1:
            return .math(+, lhs: advancePC(), rhs: advancePC(), dest: advancePC())
        case 2:
            return .math(*, lhs: advancePC(), rhs: advancePC(), dest: advancePC())
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
                pc = memory.endIndex
            }
        }
    }
}

var computer = Computer(memory: program)

computer.memory[1...2] = [12, 02]
computer.run()

print(computer.memory[0])
