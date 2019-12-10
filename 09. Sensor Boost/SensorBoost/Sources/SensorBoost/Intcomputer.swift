
public class Intcomputer {
    public typealias Value = Int
    public typealias Program = [Value]
    public typealias Memory = Intcomputer.Program
    public typealias MemoryAddress = Memory.Index

    public enum SyntaxError: Error {
        case invalidOpcode(Int)
        case invalidParameterMode(Int)
        case invalidParameterModeForDestination(Int)
    }

    public enum RuntimeError: Error {
        case illegalMemoryAddress(Int)
        case illegalJump(MemoryAddress)
    }

    private enum Instruction {
        case noop
        case add(lhs: Parameter, rhs: Parameter, dest: MemoryAddress)
        case multiply(lhs: Parameter, rhs: Parameter, dest: MemoryAddress)
        case input(dest: MemoryAddress)
        case output(source: Parameter)
        case jumpIfTrue(condition: Parameter, location: Parameter)
        case jumpIfFalse(condition: Parameter, location: Parameter)
        case lessThan(lhs: Parameter, rhs: Parameter, dest: MemoryAddress)
        case equals(lhs: Parameter, rhs: Parameter, dest: MemoryAddress)
        case halt
    }

    private enum Parameter {
        case position(MemoryAddress)
        case immediate(Value)
    }

    public var input: Pipe<Value> = Pipe()
    public var output: Pipe<Value> = Pipe()

    private var memory: Memory
    private var ip: MemoryAddress
    private var executionState: ExecutionState

    private enum ExecutionState {
        case running, waitingForInput(MemoryAddress), halted
    }

    public init(program: Program = [99]) {
        self.memory = program
        self.ip = memory.startIndex
        self.executionState = .running
    }

    public var isRunning: Bool {
        switch executionState {
        case .running, .waitingForInput:
            return true
        case .halted:
            return false
        }
    }

    private func read(from address: MemoryAddress) throws -> Value {
        guard address >= memory.startIndex else {
            throw RuntimeError.illegalMemoryAddress(address)
        }

        return address < memory.endIndex ? memory[address] : 0
    }

    private func write(_ value: Value, to address: MemoryAddress) throws {
        guard address >= memory.startIndex else {
            throw RuntimeError.illegalMemoryAddress(address)
        }

        let underflow = memory.distance(from: memory.index(before: memory.endIndex), to: address)

        if underflow > 0 {
            memory += Array(repeating: 0, count: underflow)
        }

        memory[address] = value
    }

    private func readInput(into dest: MemoryAddress) throws {
        if let value = input.read() {
            try write(value, to: dest)
            executionState = .running
        } else {
            executionState = .waitingForInput(dest)
        }
    }

    private func writeOutput(_ value: Value) throws {
        output.write(value)
    }

    private func jump(to address: MemoryAddress) throws {
        guard memory.indices.contains(address) else {
            throw RuntimeError.illegalJump(address)
        }

        ip = address
    }

    private func chompValue() throws -> Value {
        let value = try read(from: ip)
        ip = memory.index(after: ip)
        return value
    }

    private func chompAddress() throws -> MemoryAddress {
        try chompValue()
    }

    private func chompInstruction() throws -> Instruction {
        let opcodeAndParameterModes = try chompValue()
        let opcode = opcodeAndParameterModes % 100
        var parameterModes = Array(String(opcodeAndParameterModes / 100).map({ $0.wholeNumberValue! }))

        func chompParameter() throws -> Parameter {
            let mode = parameterModes.popLast() ?? 0

            switch mode {
            case 0:
                return try .position(chompAddress())
            case 1:
                return try .immediate(chompValue())
            default:
                throw SyntaxError.invalidParameterMode(mode)
            }
        }

        func chompParameterAddress() throws -> MemoryAddress {
            switch try chompParameter() {
            case .position(let address):
                return address
            case .immediate:
                throw SyntaxError.invalidParameterModeForDestination(1)
            }
        }

        switch opcode {
        case 0:
            return .noop
        case 1:
            return try .add(lhs: chompParameter(), rhs: chompParameter(), dest: chompParameterAddress())
        case 2:
            return try .multiply(lhs: chompParameter(), rhs: chompParameter(), dest: chompParameterAddress())
        case 3:
            return try .input(dest: chompParameterAddress())
        case 4:
            return try .output(source: chompParameter())
        case 5:
            return try .jumpIfTrue(condition: chompParameter(), location: chompParameter())
        case 6:
            return try .jumpIfFalse(condition: chompParameter(), location: chompParameter())
        case 7:
            return try .lessThan(lhs: chompParameter(), rhs: chompParameter(), dest: chompParameterAddress())
        case 8:
            return try .equals(lhs: chompParameter(), rhs: chompParameter(), dest: chompParameterAddress())
        case 99:
            return .halt
        default:
            throw SyntaxError.invalidOpcode(opcode)
        }
    }

    private func resolve(_ parameter: Parameter) throws -> Value {
        switch parameter {
        case .position(let address):
            return try read(from: address)
        case .immediate(let value):
            return value
        }
    }

    public func tick() throws {
        switch executionState {
        case .halted:
            break // no op
        case .running:
            try executeNextInstruction()
        case .waitingForInput(let dest):
            try readInput(into: dest)
        }
    }

    private func executeNextInstruction() throws {
        let instruction = try chompInstruction()

        switch instruction {
        case .noop:
            break
        case .add(let lhs, let rhs, let dest):
            try write(resolve(lhs) + resolve(rhs), to: dest)
        case .multiply(let lhs, let rhs, let dest):
            try write(resolve(lhs) * resolve(rhs), to: dest)
        case .input(let dest):
            try readInput(into: dest)
        case .output(let source):
            try writeOutput(resolve(source))
        case .jumpIfTrue(let condition, let location):
            if try resolve(condition) != 0 {
                try jump(to: resolve(location))
            }
        case .jumpIfFalse(let condition, let location):
            if try resolve(condition) == 0 {
                try jump(to: resolve(location))
            }
        case .lessThan(let lhs, let rhs, let dest):
            try write(resolve(lhs) < resolve(rhs) ? 1 : 0, to: dest)
        case .equals(let lhs, let rhs, let dest):
            try write(resolve(lhs) == resolve(rhs) ? 1 : 0, to: dest)
        case .halt:
            executionState = .halted
        }
    }
}
