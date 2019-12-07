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
    case illegalInputAccess
    case illegalMemoryAccess(MemoryAddress)
    case illegalJump(MemoryAddress)
}

//public struct Computer {
//    var memory: Memory
//    var input: ArraySlice<ComputeValue> // Must be ArraySlice to have popFirst()
//    var output: [ComputeValue]
//    var ip: MemoryAddress
//
//    func read(from address: MemoryAddress) throws -> ComputeValue {
//        guard memory.indices.contains(address) else {
//            throw RuntimeError.illegalMemoryAccess(address)
//        }
//
//        return memory[address]
//    }
//
//    func write(_ value: ComputeValue, to address: MemoryAddress) throws {
//        guard memory.indices.contains(address) else {
//            throw RuntimeError.illegalMemoryAccess(address)
//        }
//
//        memory[address] = value
//    }
//
//    func readInput() throws -> ComputeValue {
//        guard let value = input.popFirst() else {
//            throw RuntimeError.illegalInputAccess
//        }
//
//        return value
//    }
//
//    func writeOutput(_ value: ComputeValue) {
//        output.append(value)
//    }
//
//    func jump(to address: MemoryAddress) throws {
//        guard memory.indices.contains(address) else {
//            throw RuntimeError.illegalJump(address)
//        }
//
//        ip = address
//    }
//
//    func chompValue() throws -> ComputeValue {
//        let value = try read(from: ip)
//        ip = memory.index(after: ip)
//        return value
//    }
//
//    func chompInstruction() throws -> Instruction {
//        let opcodeAndParameterModes = try chompValue()
//        let opcode = opcodeAndParameterModes % 100
//        var parameterModes = Array(String(opcodeAndParameterModes / 100).map({ $0.wholeNumberValue! }))
//
//        func chompParameter() throws -> Parameter {
//            let mode = parameterModes.popLast() ?? 0
//
//            switch mode {
//            case 0:
//                return try .position(chompValue())
//            case 1:
//                return try .immediate(chompValue())
//            default:
//                throw SyntaxError.invalidParameterMode(mode)
//            }
//        }
//
//        switch opcode {
//        case 1:
//            return try .add(lhs: chompParameter(), rhs: chompParameter(), dest: chompValue())
//        case 2:
//            return try .multiply(lhs: chompParameter(), rhs: chompParameter(), dest: chompValue())
//        case 3:
//            return try .input(chompValue())
//        case 4:
//            return try .output(chompParameter())
//        case 5:
//            return try .jumpIfTrue(condition: chompParameter(), location: chompParameter())
//        case 6:
//            return try .jumpIfFalse(condition: chompParameter(), location: chompParameter())
//        case 7:
//            return try .lessThan(lhs: chompParameter(), rhs: chompParameter(), dest: chompValue())
//        case 8:
//            return try .equals(lhs: chompParameter(), rhs: chompParameter(), dest: chompValue())
//        case 99:
//            return .halt
//        default:
//            throw SyntaxError.invalidOpcode(opcode)
//        }
//    }
//
//    func fetch(_ parameter: Parameter) throws -> ComputeValue {
//        switch parameter {
//        case .position(let address):
//            return try read(from: address)
//        case .immediate(let value):
//            return value
//        }
//    }
//}

public func compute(label: String, program: Memory, input: () -> ComputeValue, output: (ComputeValue) -> Void) throws {
    var memory: Memory

    func read(from address: MemoryAddress) throws -> ComputeValue {
        guard memory.indices.contains(address) else {
            throw RuntimeError.illegalMemoryAccess(address)
        }

        return memory[address]
    }

    func write(_ value: ComputeValue, to address: MemoryAddress) throws {
        guard memory.indices.contains(address) else {
            throw RuntimeError.illegalMemoryAccess(address)
        }

        memory[address] = value
    }

//    var input: ArraySlice<ComputeValue> = ArraySlice(input) // Must be ArraySlice to have popFirst()

    func readInput() throws -> ComputeValue {
//        guard let value = input.popFirst() else {
//            throw RuntimeError.illegalInputAccess
//        }
//
//        return value
        print("\(label) reading from input...")
        let value = input()
        print("... \(label) read from input: \(value)")
        return value
    }

//    var output: [ComputeValue]

    func writeOutput(_ value: ComputeValue) {
//        output.append(value)
        print("\(label) writing to output: \(value)...")
        output(value)
        print("... \(label) wrote to output")
    }

    var ip: MemoryAddress

    func jump(to address: MemoryAddress) throws {
        guard memory.indices.contains(address) else {
            throw RuntimeError.illegalJump(address)
        }

        ip = address
    }

    func chompValue() throws -> ComputeValue {
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

    func fetch(_ parameter: Parameter) throws -> ComputeValue {
        switch parameter {
        case .position(let address):
            return try read(from: address)
        case .immediate(let value):
            return value
        }
    }

    memory = program
//    input = ArraySlice(input)
//    output = []
    ip = memory.startIndex

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
            ip = memory.endIndex
        }
    }

    print("\(label) halted")
//
//    return output
}
