import struct Foundation.TimeInterval
import struct Foundation.Date

struct Intcomputer {
    typealias Value = Int
    typealias Program = [Value]
    typealias Memory = Intcomputer.Program
    typealias MemoryAddress = Memory.Index

    typealias Input = () -> Value?
    typealias Output = (Value) -> Void

    enum SyntaxError: Error {
        case invalidOpcode(Int)
        case invalidParameterMode(Int)
        case invalidParameterModeForDestination(Int)
    }

    enum RuntimeError: Error {
        case illegalMemoryAddress(Int)
        case illegalJump(MemoryAddress)
        case runTimedOut
    }

    private enum Instruction {
        case noop
        case add(lhs: Parameter, rhs: Parameter, dest: Parameter.Address)
        case multiply(lhs: Parameter, rhs: Parameter, dest: Parameter.Address)
        case input(dest: Parameter.Address)
        case output(source: Parameter)
        case jumpIfTrue(condition: Parameter, location: Parameter)
        case jumpIfFalse(condition: Parameter, location: Parameter)
        case lessThan(lhs: Parameter, rhs: Parameter, dest: Parameter.Address)
        case equals(lhs: Parameter, rhs: Parameter, dest: Parameter.Address)
        case adjustRelativeBase(offset: Parameter)
        case halt
    }

    private enum Parameter {
        case address(Address)
        case immediate(Value)

        enum Address {
            case position(MemoryAddress)
            case relative(Int)
        }
    }

    var input: Input = { fatalError("no input to provide value") }
    var output: Output = { fatalError("no output to receive \($0)") }

    private var memory: Memory
    private var ip: MemoryAddress
    private var relativeBase: Int
    private var executionState: ExecutionState

    private enum ExecutionState {
        case running, waitingForInput(MemoryAddress), halted
    }

    init(program: Program = [99]) {
        self.memory = program
        self.ip = memory.startIndex
        self.relativeBase = 0
        self.executionState = .running
    }

    var isRunning: Bool {
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

    private mutating func write(_ value: Value, to address: MemoryAddress) throws {
        guard address >= memory.startIndex else {
            throw RuntimeError.illegalMemoryAddress(address)
        }

        let underflow = memory.distance(from: memory.index(before: memory.endIndex), to: address)

        if underflow > 0 {
            memory += Array(repeating: 0, count: underflow)
        }

        memory[address] = value
    }

    private mutating func readInput(into dest: MemoryAddress) throws {
        if let value = input() {
            try write(value, to: dest)
            executionState = .running
        } else {
            executionState = .waitingForInput(dest)
        }
    }

    private mutating func writeOutput(_ value: Value) throws {
        output(value)
    }

    private mutating func jump(to address: MemoryAddress) throws {
        guard memory.indices.contains(address) else {
            throw RuntimeError.illegalJump(address)
        }

        ip = address
    }

    private mutating func chompValue() throws -> Value {
        let value = try read(from: ip)
        ip = memory.index(after: ip)
        return value
    }

    private mutating func chompAddress() throws -> MemoryAddress {
        try chompValue()
    }

    private mutating func chompInstruction() throws -> Instruction {
        let opcodeAndParameterModes = try chompValue()
        let opcode = opcodeAndParameterModes % 100
        var parameterModes = Array(String(opcodeAndParameterModes / 100).map({ $0.wholeNumberValue! }))

        func chompParameter() throws -> Parameter {
            let mode = parameterModes.popLast() ?? 0

            switch mode {
            case 0:
                return try .address(.position(chompAddress()))
            case 1:
                return try .immediate(chompValue())
            case 2:
                return try .address(.relative(chompValue()))
            default:
                throw SyntaxError.invalidParameterMode(mode)
            }
        }

        func chompParameterAddress() throws -> Parameter.Address {
            switch try chompParameter() {
            case .address(let address):
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
        case 9:
            return try .adjustRelativeBase(offset: chompParameter())
        case 99:
            return .halt
        default:
            throw SyntaxError.invalidOpcode(opcode)
        }
    }

    private func resolve(_ parameter: Parameter) throws -> Value {
        switch parameter {
        case .address(let address):
            return try read(from: resolve(address))
        case .immediate(let value):
            return value
        }
    }

    private func resolve(_ address: Parameter.Address) throws -> MemoryAddress {
        switch address {
        case .position(let address):
            return address
        case .relative(let offset):
            return memory.index(memory.startIndex, offsetBy: relativeBase + offset)
        }
    }

    mutating func run(timeout: TimeInterval? = nil) throws {
        let end = timeout.map({ Date(timeIntervalSinceNow: $0) }) ?? Date.distantFuture

        while isRunning {
            if end.timeIntervalSinceNow < 0 {
                throw RuntimeError.runTimedOut
            }

            try tick()
        }
    }

    mutating func tick() throws {
        switch executionState {
        case .halted:
            break // no op
        case .running:
            try executeNextInstruction()
        case .waitingForInput(let dest):
            try readInput(into: dest)
        }
    }

    private mutating func executeNextInstruction() throws {
        let instruction = try chompInstruction()

        switch instruction {
        case .noop:
            break
        case .add(let lhs, let rhs, let dest):
            try write(resolve(lhs) + resolve(rhs), to: resolve(dest))
        case .multiply(let lhs, let rhs, let dest):
            try write(resolve(lhs) * resolve(rhs), to: resolve(dest))
        case .input(let dest):
            try readInput(into: resolve(dest))
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
            try write(resolve(lhs) < resolve(rhs) ? 1 : 0, to: resolve(dest))
        case .equals(let lhs, let rhs, let dest):
            try write(resolve(lhs) == resolve(rhs) ? 1 : 0, to: resolve(dest))
        case .adjustRelativeBase(let offset):
            try relativeBase += resolve(offset)
        case .halt:
            executionState = .halted
        }
    }
}
