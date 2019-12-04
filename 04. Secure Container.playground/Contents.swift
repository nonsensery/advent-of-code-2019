import UIKit

func countPasswords(in range: ClosedRange<Int>) -> Int {
    range
        .lazy
        .map({ String($0).map({ $0.wholeNumberValue! }) })
        .filter({ $0.streaks().contains(where: { $0.count >= 2 }) })
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

print(countPasswords(in: 307237...769058))
// 889
