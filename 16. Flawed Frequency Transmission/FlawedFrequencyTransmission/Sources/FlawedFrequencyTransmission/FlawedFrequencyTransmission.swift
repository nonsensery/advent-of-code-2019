
func fft(_ input: [Int], lowestRelevantIndex: Int = 0) -> [Int] {
    let n = input.count
    var output = Array(repeating: 0, count: n)
    var result = 0

    for i in (lowestRelevantIndex ..< n).reversed() {
        let repetitionCount = i + 1
        var remaining = RangeSlice(input.indices)
        var correctionSize = 0

        // Skip initial 0s (doing this separately because the number of 0s is unusual)
        remaining = remaining.dropFirst(repetitionCount - 1)
        correctionSize += 1

        while !remaining.isEmpty {
            // Add 1s
            for i in remaining.prefix(correctionSize).indices {
                result += input[i]
            }
            remaining = remaining.dropFirst(repetitionCount)
            correctionSize += 1

            // Un-add 0s
            for i in remaining.prefix(correctionSize).indices {
                result -= input[i]
            }
            remaining = remaining.dropFirst(repetitionCount)
            correctionSize += 1

            // Subtract -1s
            for i in remaining.prefix(correctionSize).indices {
                result -= input[i]
            }
            remaining = remaining.dropFirst(repetitionCount)
            correctionSize += 1

            // Un-subtract 0s
            for i in remaining.prefix(correctionSize).indices {
                result += input[i]
            }
            remaining = remaining.dropFirst(repetitionCount)
            correctionSize += 1
        }

        output[i] = abs(result) % 10
    }

    return output
}
