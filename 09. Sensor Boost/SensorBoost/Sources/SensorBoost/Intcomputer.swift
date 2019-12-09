public typealias ComputeValue = Int
public typealias Memory = [ComputeValue]
public typealias MemoryAddress = Memory.Index

enum Instruction {
    case add(lhs: Parameter, rhs: Parameter, dest: MemoryAddress)
    case multiply(lhs: Parameter, rhs: Parameter, dest: MemoryAddress)
    case input(MemoryAddress)
    case output(Parameter)
    case jumpIfTrue(condition: Parameter, location: Parameter)
    case jumpIfFalse(condition: Parameter, location: Parameter)
    case lessThan(lhs: Parameter, rhs: Parameter, dest: MemoryAddress)
    case equals(lhs: Parameter, rhs: Parameter, dest: MemoryAddress)
    case halt
}

enum Parameter {
    case position(MemoryAddress)
    case immediate(ComputeValue)
}

public enum SyntaxError: Error {
    case invalidOpcode(Int)
    case invalidParameterMode(Int)
}

public enum RuntimeError: Error {
    case illegalMemoryAccess(MemoryAddress)
    case illegalJump(MemoryAddress)
}

public class Computer {
    public var input: Pipe<ComputeValue> = Pipe()
    public var output: Pipe<ComputeValue> = Pipe()

    private var memory: Memory
    private var ip: MemoryAddress
    private var state: State

    private enum State {
        case running, waitingForInput(MemoryAddress), halted
    }

    public init(program: Memory = [99]) {
        self.memory = program
        self.ip = memory.startIndex
        self.state = .running
    }

    public var isHalted: Bool {
        switch state {
        case .running, .waitingForInput:
            return false
        case .halted:
            return true
        }
    }

    private func read(from address: MemoryAddress) throws -> ComputeValue {
        guard memory.indices.contains(address) else {
            throw RuntimeError.illegalMemoryAccess(address)
        }

        return memory[address]
    }

    private func write(_ value: ComputeValue, to address: MemoryAddress) throws {
        guard memory.indices.contains(address) else {
            throw RuntimeError.illegalMemoryAccess(address)
        }

        memory[address] = value
    }

    private func readInput(into dest: MemoryAddress) throws {
//        guard let input = input else {
//            throw RuntimeError.illegalInputAccess
//        }
//
        if let value = input.read() {
            try write(value, to: dest)
            state = .running
        } else {
            state = .waitingForInput(dest)
        }
    }

    private func writeOutput(_ value: ComputeValue) throws {
//        guard let output = output else {
//            throw RuntimeError.illegalOutputAccess
//        }
//
        output.write(value)
    }

    private func jump(to address: MemoryAddress) throws {
        guard memory.indices.contains(address) else {
            throw RuntimeError.illegalJump(address)
        }

        ip = address
    }

    private func chompValue() throws -> ComputeValue {
        let value = try read(from: ip)
        ip = memory.index(after: ip)
        return value
    }

    private func chompInstruction() throws -> Instruction {
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
            return try .input(chompValue())
        case 4:
            return try .output(chompParameter())
        case 5:
            return try .jumpIfTrue(condition: chompParameter(), location: chompParameter())
        case 6:
            return try .jumpIfFalse(condition: chompParameter(), location: chompParameter())
        case 7:
            return try .lessThan(lhs: chompParameter(), rhs: chompParameter(), dest: chompValue())
        case 8:
            return try .equals(lhs: chompParameter(), rhs: chompParameter(), dest: chompValue())
        case 99:
            return .halt
        default:
            throw SyntaxError.invalidOpcode(opcode)
        }
    }

    private func fetch(_ parameter: Parameter) throws -> ComputeValue {
        switch parameter {
        case .position(let address):
            return try read(from: address)
        case .immediate(let value):
            return value
        }
    }

    public func tick() throws {
        switch state {
        case .halted:
            break // no op
        case .running:
            try executeNextInstruction()
        case .waitingForInput(let dest):
            if let value = input.read() {
                try write(value, to: dest)
                state = .running
            }
        }
    }

    private func executeNextInstruction() throws {
        let instruction = try chompInstruction()

        switch instruction {
        case .add(let lhs, let rhs, let dest):
            try write(fetch(lhs) + fetch(rhs), to: dest)
        case .multiply(let lhs, let rhs, let dest):
            try write(fetch(lhs) * fetch(rhs), to: dest)
        case .input(let dest):
            try readInput(into: dest)
        case .output(let source):
            try writeOutput(fetch(source))
        case .jumpIfTrue(let condition, let location):
            if try fetch(condition) != 0 {
                try jump(to: fetch(location))
            }
        case .jumpIfFalse(let condition, let location):
            if try fetch(condition) == 0 {
                try jump(to: fetch(location))
            }
        case .lessThan(let lhs, let rhs, let dest):
            try write(fetch(lhs) < fetch(rhs) ? 1 : 0, to: dest)
        case .equals(let lhs, let rhs, let dest):
            try write(fetch(lhs) == fetch(rhs) ? 1 : 0, to: dest)
        case .halt:
            state = .halted
        }
    }
}
