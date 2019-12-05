import Foundation

typealias MemoryValue = Int
typealias Memory = [MemoryValue]
typealias MemoryAddress = Memory.Index

enum Instruction {
    case add(lhs: Parameter, rhs: Parameter, dest: MemoryAddress)
    case multiply(lhs: Parameter, rhs: Parameter, dest: MemoryAddress)
    case input(dest: MemoryAddress)
    case output(source: Parameter)
    case halt
}

enum Parameter {
    case position(MemoryAddress)
    case immediate(MemoryValue)
}

enum SyntaxError: Error {
    case invalidOpcode(Int)
    case invalidParameterMode(Int)
}

enum RuntimeError: Error {
    case illegalInputAccess
    case illegalMemoryAccess(MemoryAddress)
}

func compute(program: Memory, input: [MemoryValue] = []) throws -> [MemoryValue] {
    var memory = program

    func read(from address: MemoryAddress) throws -> MemoryValue {
        guard memory.indices.contains(address) else {
            throw RuntimeError.illegalMemoryAccess(address)
        }

        return memory[address]
    }

    func write(_ value: MemoryValue, to address: MemoryAddress) throws {
        guard memory.indices.contains(address) else {
            throw RuntimeError.illegalMemoryAccess(address)
        }

        memory[address] = value
    }

    var input = ArraySlice(input) // Must be ArraySlice to have popFirst()

    func readInput() throws -> MemoryValue {
        guard let value = input.popFirst() else {
            throw RuntimeError.illegalInputAccess
        }

        return value
    }

    var output: [MemoryValue] = []

    func writeOutput(_ value: MemoryValue) {
        output.append(value)
    }

    var ip = memory.startIndex

    func chompValue() throws -> MemoryValue {
        let value = try read(from: ip)
        ip = memory.index(after: ip)
        return value
    }

    func chompInstruction() throws -> Instruction {
        let opcodeAndParameterModes = try chompValue()
        let opcode = opcodeAndParameterModes % 100
        var parameterModes = Array(String(opcodeAndParameterModes / 100).map({ $0.wholeNumberValue! }))

        func chompParameter() throws -> Parameter {
            let mode = parameterModes.popLast() ?? 0

            switch mode {
            case 0:
                return try .position(chompValue())
            case 1:
                return try .immediate(chompValue())
            default:
                throw SyntaxError.invalidParameterMode(mode)
            }
        }

        switch opcode {
        case 1:
            return try .add(lhs: chompParameter(), rhs: chompParameter(), dest: chompValue())
        case 2:
            return try .multiply(lhs: chompParameter(), rhs: chompParameter(), dest: chompValue())
        case 3:
            return try .input(dest: chompValue())
        case 4:
            return try .output(source: chompParameter())
        case 99:
            return .halt
        default:
            throw SyntaxError.invalidOpcode(opcode)
        }
    }

    func fetch(_ parameter: Parameter) throws -> MemoryValue {
        switch parameter {
        case .position(let address):
            return try read(from: address)
        case .immediate(let value):
            return value
        }
    }

    while ip < memory.endIndex {
        let instruction = try chompInstruction()

        switch instruction {
        case .add(let lhs, let rhs, let dest):
            try write(fetch(lhs) + fetch(rhs), to: dest)
        case .multiply(let lhs, let rhs, let dest):
            try write(fetch(lhs) * fetch(rhs), to: dest)
        case .input(let dest):
            try write(readInput(), to: dest)
        case .output(let source):
            try writeOutput(fetch(source))
        case .halt:
            ip = memory.endIndex
        }
    }

    return output
}

let program = Bundle.main.url(forResource: "input", withExtension: "txt")
    .flatMap({ try? Data(contentsOf: $0) })
    .flatMap({ String(data: $0, encoding: .utf8) })
    .map({ $0.trimmingCharacters(in: .whitespacesAndNewlines) })?
    .split(separator: ",")
    .map({ MemoryValue($0)! })
    ?? []

// MARK: Part 1

print(try! compute(program: program, input: [1]).last!)
