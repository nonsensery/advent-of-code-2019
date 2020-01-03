@testable import SlamShuffle

enum Instruction {
    case dealIntoNewStack
    case cut(n: Int)
    case deal(increment: Int)

    init?<S: StringProtocol>(_ instruction: S) {
        if instruction == "deal into new stack" {
            self = .dealIntoNewStack
        } else if instruction.hasPrefix("deal with increment "), let increment = Int(instruction.dropFirst("deal with increment ".count)) {
            self = .deal(increment: increment)
        } else if instruction.hasPrefix("cut "), let n = Int(instruction.dropFirst("cut ".count)) {
            self = .cut(n: n)
        } else {
            return nil
        }
    }

    static func all<S: StringProtocol>(_ instructions: S) -> [Self] {
        instructions
            .split(separator: "\n")
            .compactMap {
                Self($0)
            }
    }
}

extension Deck: CustomStringConvertible, ExpressibleByStringLiteral {
    public init(stringLiteral: String) {
        self.init(values: stringLiteral.split(whereSeparator: { $0.isWhitespace }).map({ Int($0)! }))
    }

    public var description: String {
        cardValues.map(String.init).joined(separator: " ")
    }
}

extension Shufflable {
    mutating func performAll<S: StringProtocol>(_ instructions: S) {
        performAll(Instruction.all(instructions))
    }

    mutating func performAll(_ instructions: [Instruction]) {
        instructions.forEach {
            perform($0)
        }
    }

    mutating func perform(_ instruction: Instruction) {
        switch instruction {
        case .dealIntoNewStack:
            dealIntoNewStack()
        case .deal(let increment):
            deal(increment: increment)
        case .cut(let n):
            cut(n: n)
        }
    }

    mutating func reversePerformAll<S: StringProtocol>(_ instructions: S) {
        reversePerformAll(Instruction.all(instructions))
    }

    mutating func reversePerformAll(_ instructions: [Instruction]) {
        instructions
            .reversed()
            .forEach {
                reversePerform($0)
            }
    }

    mutating func reversePerform(_ instruction: Instruction) {
        switch instruction {
        case .dealIntoNewStack:
            reverseDealIntoNewStack()
        case .deal(let increment):
            reverseDeal(increment: increment)
        case .cut(let n):
            reverseCut(n: n)
        }
    }
}
