
public func findStationLocation(_ asteroids: [Location]) -> (station: Location, detected: Int)? {
    asteroids
        .lazy
        .pairs()
        .reduce(into: [:] as [Location: Set<Heading>]) { headings, ab in
            let (a, b) = ab
            let heading = Route(from: a, to: b).heading
            headings[a, default: []].insert(heading)
            headings[b, default: []].insert(heading.reversed)
        }
        .mapValues({ $0.count })
        .max(by: { $0.value < $1.value })
        .map({ $0 })
}

public extension Array where Element == Location {
    func sortedByVaporizationOrder(from station: Location) -> Self {
        var stacks = self
            .lazy
            // Remove station from list of locations:
            .filter({ $0 != station })
            // Include route (from station) for grouping and sorting later:
            .map({ (location: $0, route: Route(from: station, to: $0)) })
            // Group locations by heading:
            .grouped(by: { $0.route.heading })
            .mapValues { locations in
                locations
                    // Sort locations in each group by number of hops away (along this heading):
                    .sorted(by: { $0.route.hops < $1.route.hops })
                    // Drop the route since we no longer need it
                    .map({ $0.location })
            }
            // Convert to an array and include heading angle for sorting later:
            .map({ (angle: $0.key.angle, locations: $0.value )})
            // Sort groups by angle at which the lazer points along that heading:
            .sorted(by: { $0.angle < $1.angle })
            // Drop angle since we not longer need it:
            .map({ $0.locations })
            // Convert to slice so we can use `dropFirst()` later
            .map({ ArraySlice($0) })

        // `stacks` is an array (sorted by angle) of arrays (sorted by distance) of locations

        var result: [Location] = []
        result.reserveCapacity(stacks.lazy.map({ $0.count }).reduce(0, +))

        while !stacks.isEmpty {
            let thisRotation = stacks.map({ $0.first! })
            result.append(contentsOf: thisRotation)

            stacks = stacks.map({ $0.dropFirst() }).filter({ !$0.isEmpty })
        }

        return result
    }
}

private extension Sequence {
    func grouped<Key: Hashable>(by keyForValue: (Element) throws -> Key) rethrows -> [Key: [Element]] {
        try Dictionary(grouping: self, by: keyForValue)
    }
}
