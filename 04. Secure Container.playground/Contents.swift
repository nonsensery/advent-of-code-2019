
let range = 307237...769058

func countPasswords(in range: ClosedRange<Int>, isAcceptableStreak: @escaping ([UInt8]) -> Bool) -> Int {
    sequence(state: range.lowerBound - 1) { (x: inout Int) -> Int? in
        x = (x + 1).liftingDigits()

        return range ~= x ? x : nil
    }
    .filter({ $0.digits.streaks().contains(where: isAcceptableStreak) })
    .count
}

extension Int {
    init(digits: [UInt8]) {
        self = Int(digits.map({ String($0) }).joined()) ?? 0
    }

    var digits: [UInt8] {
        String(self).map({ $0.wholeNumberValue! }).map({ UInt8(exactly: $0)! })
    }

    /// Gets the smallest value greater than or equal to self where successive digits do not decrease.
    func liftingDigits() -> Int {
        let digits = self.digits

        if let ((value, _), i) = zip(zip(digits, digits.dropFirst()), digits.indices.dropFirst()).first(where: { $0.0.0 > $0.0.1 }) {
            return Self(digits: digits.prefix(i) + Array(repeating: value, count: digits.count - i))
        } else {
            return self
        }
    }
}

extension Array where Element: Equatable {
    func streaks() -> [[Element]] {
        reduce(into: []) { streaks, element in
            if element != streaks.last?.last {
                streaks.append([])
            }

            let lastIndex = streaks.index(before: streaks.endIndex)

            streaks[lastIndex].append(element)
        }
    }
}

print(countPasswords(in: range, isAcceptableStreak: { $0.count >= 2 }))
// 889

print(countPasswords(in: range, isAcceptableStreak: { $0.count == 2 }))
// 589
