
func findMaxThrusterSignal<S: Sequence>(program: Memory, phaseSettings: S) -> ComputeValue where S.Element == ComputeValue {
    phaseSettings
        .permutations()
        .map { phaseSettings in
            phaseSettings.reduce(0) { amplifierInput, phaseSetting in
                try! compute(program: program, input: [phaseSetting, amplifierInput])[0]
            }
        }
        .reduce(0, max)
}

// MARK: - Part 1

let phaseSettings = 0...4

print("sample1: \(findMaxThrusterSignal(program: Resource.sample1_txt.values(), phaseSettings: phaseSettings))")
print("sample2: \(findMaxThrusterSignal(program: Resource.sample2_txt.values(), phaseSettings: phaseSettings))")
print("sample3: \(findMaxThrusterSignal(program: Resource.sample3_txt.values(), phaseSettings: phaseSettings))")
print("input: \(findMaxThrusterSignal(program: Resource.input_txt.values(), phaseSettings: phaseSettings))")
