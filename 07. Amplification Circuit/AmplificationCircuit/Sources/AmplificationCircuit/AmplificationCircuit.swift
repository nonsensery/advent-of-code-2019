import Foundation

// MARK: - Part 1

//func findMaxThrusterSignal<S>(program: Memory, phaseSettings: S) -> ComputeValue where S: Sequence, S.Element == ComputeValue {
//    phaseSettings
//        .permutations()
//        .map { phaseSettings in
//            phaseSettings.reduce(0) { amplifierInput, phaseSetting in
//                try! compute(program: program, input: [phaseSetting, amplifierInput])[0]
//            }
//        }
//        .reduce(0, max)
//}
//
//print("sample1: \(findMaxThrusterSignal(program: Resource.sample1_txt.values(), phaseSettings: 0...4))")
//print("sample2: \(findMaxThrusterSignal(program: Resource.sample2_txt.values(), phaseSettings: 0...4))")
//print("sample3: \(findMaxThrusterSignal(program: Resource.sample3_txt.values(), phaseSettings: 0...4))")
//print("input: \(findMaxThrusterSignal(program: Resource.input_txt.values(), phaseSettings: 0...4))")

// MARK: - Part 2


func findMaxThrusterSignalWithFeedback<S>(program: Memory, phaseSettings: S) -> ComputeValue where S: Sequence, S.Element == ComputeValue {
    let pipes = phaseSettings.map({ MyPipe<ComputeValue>(label: "Pipe<\(10 - $0)>") })
    let group = DispatchGroup()

    let inputs = pipes.suffix(1) + pipes.dropLast()
    let outputs = pipes.dropFirst() + pipes.prefix(1)

    zip(zip(inputs, outputs), phaseSettings).forEach {
        let ((input, output), phaseSetting) = $0
        let group = DispatchGroup()

        input.write(phaseSetting)

        DispatchQueue.global().async {
            group.enter()
            try! compute(label: "Computer<\(10 - phaseSetting)>", program: program, input: input.read, output: output.write)
            group.leave()
        }
    }

    group.wait()

    return pipes.last!.read()
}
//
//print("sample4: \(findMaxThrusterSignalWithFeedback(program: Resource.sample1_txt.values(), phaseSettings: 5...9))")
//
