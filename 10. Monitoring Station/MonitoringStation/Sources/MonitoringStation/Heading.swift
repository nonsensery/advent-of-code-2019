import func Foundation.atan

public struct Heading: Hashable {
    public var dx: Int
    public var dy: Int

    public init(_ dx: Int, _ dy: Int) {
        assert(dx != 0 || dy != 0)
        self.dx = dx
        self.dy = dy
    }

    public init(from a: Location, to b: Location) {
        self.init(b.x - a.x, b.y - a.y)
    }

    public var reversed: Heading {
        Heading(-dx, -dy)
    }

    /// The angle, in degrees, between this heading and the "-y" axis, where angles increase clockwise.
    public var angle: Double {
        let base = atan(Double(dy) / Double(dx)) * 180 / .pi

        switch (dx >= 0, dy >= 0) {
        case (true, true):
            return base + 90
        case (false, true):
            return base + 270
        case (false, false):
            return base + 270
        case (true, false):
            return base + 90
        }
    }
}
