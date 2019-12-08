
public extension Array {
    /// Gets all permutations of the elements in this array.
    func permutations() -> [[Element]] {
        func generate(prefix: [Element] = [], remaining: [Element], yield: ([Element]) -> Void) {
            guard !remaining.isEmpty else {
                yield(prefix)
                return
            }

            for i in remaining.indices {
                var excluding = remaining
                excluding.remove(at: i)
                generate(prefix: prefix + [remaining[i]], remaining: excluding, yield: yield)
            }

        }

        var result: [[Element]] = []
        generate(remaining: self, yield: { result.append($0) })

        return result
    }
}
