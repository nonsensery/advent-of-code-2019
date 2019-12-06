
extension Resource {
    // Dictionary mapping from name of an object to the name of the object it orbits.
    var mappings: [String: String] {
        Dictionary(
            uniqueKeysWithValues: lines()
                .lazy
                .map({ $0.split(separator: ")").map(String.init) })
                .map({ (key: $0[1], value: $0[0]) })
        )
    }
}

// MARK: - Part 1

func countOrbits(mappings: [String: String]) -> Int {
    var memo: [String: Int] = [:]

    func countOrbits(satellite: String) -> Int {
        if let known = memo[satellite] {
            return known
        }

        guard let center = mappings[satellite] else {
            return 0
        }

        let count = 1 + countOrbits(satellite: center)
        memo[satellite] = count
        return count
    }

    return mappings.keys.map({ countOrbits(satellite: $0) }).reduce(0, +)
}

print(countOrbits(mappings: Resource.sample1_txt.mappings)) // => 42
print(countOrbits(mappings: Resource.input_txt.mappings)) // => 322508
