
public extension Array {
    private var lastIndex: Index {
        index(before: endIndex)
    }

    /// Splits `self` into a series of chunks of the given size. The if `self.count` is not an even multiple of `size`,
    /// the last chunk will be smaller.
    func chunks(size: Int) -> [[Element]] {
        reduce(into: []) { chunks, element in
            if chunks.isEmpty || chunks.last?.count == size {
                chunks.append([])
            }

            chunks[chunks.lastIndex].append(element)
        }
    }
}
