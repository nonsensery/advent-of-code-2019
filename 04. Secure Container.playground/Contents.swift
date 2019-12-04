import UIKit

func countPasswords(in range: ClosedRange<Int>) -> Int {
    var count = 0

    range.forEach { x in
        let digits = String(x).map({ $0.wholeNumberValue! })

        guard hasRepeatedElement(digits) else {
            return
        }

        guard !hasDecreasingElements(digits) else {
            return
        }

        count += 1
    }

    return count
}

func hasRepeatedElement<T: Hashable>(_ array: [T]) -> Bool {
    var seen = Set<T>()

    for element in array {
        if !seen.insert(element).inserted {
            return true
        }
    }

    return false
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
