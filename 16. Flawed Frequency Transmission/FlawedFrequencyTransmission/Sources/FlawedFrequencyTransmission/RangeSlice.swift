
/// Similar to using an ArraySlice, but it doesn't cause the underlying array to be multiply-referenced.
struct RangeSlice {
    let base: Range<Int>
    private(set) var offset: Int

    init(_ base: Range<Int>, offset: Int = 0) {
        self.base = base
        self.offset = offset
    }

    func prefix(_ maxLength: Int) -> Range<Int> {
        assert(maxLength >= 0)
        let lowerBound = min(base.lowerBound + offset, base.upperBound)
        return lowerBound ..< min(lowerBound + maxLength, base.upperBound)
    }

    var isEmpty: Bool {
        offset >= base.upperBound
    }

    func dropFirst(_ length: Int = 1) -> Self {
        assert(length >= 0)
        return RangeSlice(base, offset: min(offset + length, base.upperBound))
    }
}
