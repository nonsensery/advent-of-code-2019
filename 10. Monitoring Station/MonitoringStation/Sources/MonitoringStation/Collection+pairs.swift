
extension Collection {
    private func forEachPair(_ body: (Element, Element) -> Void) {
        var remaining = self.dropFirst(0)

        while let a = remaining.popFirst() {
            remaining.forEach { b in
                body(a, b)
            }
        }
    }

    func pairs() -> [(Element, Element)] {
        var pairs: [(Element, Element)] = []
        pairs.reserveCapacity(count * (count - 1) / 2) // "n choose 2" = n * (n - 1) / 2
        forEachPair({ pairs.append(($0, $1)) })
        return pairs
    }
}
