import Foundation

 // MARK: - Part 1

public func findMaxThrusterSignalAndPhaseSettings(program: Memory, phaseSettings: [ComputeValue])
    throws -> (thrusterSignal: ComputeValue, phaseSettings: [Int])? {

    try phaseSettings
        .permutations()
        .map {
            (
                thrusterSignal: try findMaxThrusterSignalWithFeedback(program: program, phaseSettings: $0) ?? 0,
                phaseSettings: $0
            )
        }
        .max(by: { $0.thrusterSignal < $1.thrusterSignal })
}

public func findMaxThrusterSignal(program: Memory, phaseSettings: [ComputeValue]) throws -> ComputeValue? {
    let computers = phaseSettings.map { _ in
        Computer(program: program)
    }

    zip(computers, computers.dropFirst()).forEach {
        $0.1.input = $0.0.output
    }

    zip(computers, phaseSettings).forEach {
        $0.0.input.write($0.1)
    }

    computers.first?.input.write(0)

    while computers.contains(where: { !$0.isHalted }) {
        try computers.forEach({ try $0.tick() })
    }

    return computers.last?.output.read()
}

// MARK: - Part 2

public func findMaxThrusterSignalWithFeedback(program: Memory,
                                              phaseSettings: [ComputeValue]) throws -> ComputeValue? {
    let computers = phaseSettings.map { _ in
        Computer(program: program)
    }

    zip(computers, computers.dropFirst() + computers.prefix(1)).forEach {
        $0.1.input = $0.0.output
    }

    zip(computers, phaseSettings).forEach {
        $0.0.input.write($0.1)
    }

    computers.first?.input.write(0)

    while computers.contains(where: { !$0.isHalted }) {
        try computers.forEach({ try $0.tick() })
    }

    return computers.last?.output.read()
}

public func findMaxThrusterSignalAndPhaseSettingsWithFeedback(program: Memory,
                                                              phaseSettings: [ComputeValue])
    throws -> (thrusterSignal: ComputeValue, phaseSettings: [Int])? {

    try phaseSettings
        .permutations()
        .map {
            (
                thrusterSignal: try findMaxThrusterSignalWithFeedback(program: program, phaseSettings: $0) ?? 0,
                phaseSettings: $0
            )
        }
        .max(by: { $0.thrusterSignal < $1.thrusterSignal })
}
