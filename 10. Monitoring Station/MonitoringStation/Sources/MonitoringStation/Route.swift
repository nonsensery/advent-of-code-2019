
public struct Route: Hashable {
    public let heading: Heading
    public let hops: Int

    public init(heading: Heading, hops: Int = 1) {
        assert(hops > 0)

        // Fully denormalize heading:
        let heading = Heading(heading.dx * hops, heading.dy * hops)
        var hops = 1

        // Compute fully normalized heading:
        let absDx = abs(heading.dx)
        let absDy = abs(heading.dy)
        let (big, little) = (max(absDx, absDy), min(absDx, absDy))

        if little == 0 {
            hops = big
        } else if little == 1 {
            hops = 1
        } else {
            // This is finding the greatest common denominator:
            hops = (2...little).filter({ (big % $0 == 0) && (little % $0 == 0) }).max() ?? 1
        }

        self.heading = Heading(heading.dx / hops, heading.dy / hops)
        self.hops = hops
    }

    public init(from a: Location, to b: Location) {
        self.init(heading: Heading(from: a, to: b))
    }

    public var reversed: Route {
        Route(heading: heading.reversed, hops: hops)
    }
}
