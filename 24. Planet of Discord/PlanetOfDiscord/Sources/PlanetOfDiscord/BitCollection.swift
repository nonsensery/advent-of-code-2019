
struct BitCollection<Storage>: RangeReplaceableCollection where Storage: FixedWidthInteger {
    typealias SubSequence = Self

    private(set) var storage: Storage = 0

    let startIndex = 0

    var endIndex: Int {
        storage.bitWidth
    }

    func index(after i: Int) -> Int {
        i + 1
    }

    subscript(position: Int) -> Bool {
        get {
            (storage & (1 << position)) != 0
        }

        set {
            if newValue {
                storage |= 1 << position
            } else {
                storage &= ~(1 << position)
            }
        }
    }

    subscript(bounds: Range<Int>) -> SubSequence {
        get {
            BitCollection(storage: ((storage >> bounds.lowerBound) & ~(~0 << bounds.count)))
        }

        set {
            let mask = ~(~(0 as Storage) << bounds.count) << bounds.lowerBound

            storage = (storage & ~mask) | (newValue.storage & mask)
        }
    }
}

extension BitCollection: ExpressibleByIntegerLiteral where Storage: ExpressibleByIntegerLiteral {
    init(integerLiteral i: Storage.IntegerLiteralType) {
        self.init(storage: Storage(integerLiteral: i))
    }
}
