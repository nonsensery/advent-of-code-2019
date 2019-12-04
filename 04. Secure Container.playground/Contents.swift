
let range = 307237...769058

func countPasswords(in range: ClosedRange<Int>, isAcceptableStreak: @escaping ([Int]) -> Bool) -> Int {
    range
        .lazy
        .map({ String($0).map({ $0.wholeNumberValue! }) })
        .filter({ $0.streaks().contains(where: isAcceptableStreak) })
        .filter({ !hasDecreasingElements($0) })
        .count
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

func hasDecreasingElements<T: Comparable>(_ array: [T]) -> Bool {
    guard var last = array.first else {
        return false
    }

    for element in array.dropFirst() {
        if element < last {
            return true
        }
        last = element
    }

    return false
}

print(countPasswords(in: range, isAcceptableStreak: { $0.count >= 2 }))
// 889

print(countPasswords(in: range, isAcceptableStreak: { $0.count == 2 }))
// 589
