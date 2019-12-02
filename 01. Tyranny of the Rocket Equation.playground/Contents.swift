import class Foundation.Bundle
import struct Foundation.Data

// MARK: Setup

let moduleMasses = Bundle.main.url(forResource: "modules", withExtension: "txt")
    .flatMap({ try? Data(contentsOf: $0) })
    .flatMap({ String(data: $0, encoding: .utf8) })?
    .split(whereSeparator: { $0.isNewline })
    .compactMap({ Int($0) })
    ?? []

// MARK: Part 1

func countUpFuel1(forMass mass: Int) -> Int {
    max(0, (mass / 3) - 2)
}

print(moduleMasses.map(countUpFuel1).reduce(0, +))

// MARK: Part 2

func countUpFuel2(forMass mass: Int) -> Int {
    let fuel = countUpFuel1(forMass: mass)

    if fuel > 0 {
        return fuel + countUpFuel2(forMass: fuel)
    } else {
        return fuel
    }
}

print(moduleMasses.map(countUpFuel2).reduce(0, +))
