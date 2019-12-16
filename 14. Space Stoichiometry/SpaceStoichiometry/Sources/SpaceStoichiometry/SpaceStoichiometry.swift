import func Foundation.ceil

struct SingleOutputReaction: Hashable {
    var inputs: [String: Int]
    var outputElement: String
    var outputAmount: Int
}

struct MultiOutputReaction: Hashable {
    var inputs: [String: Int]
    var outputs: [String: Int]
}

func completeReaction(producing outputAmount: Int, _ outputElement: String,
                      startingWith provided: [String: Int] = [:],
                      using reactions: [SingleOutputReaction]) -> MultiOutputReaction? {

    let reactionsByOutputElement = Dictionary(uniqueKeysWithValues: reactions.map({ (key: $0.outputElement, value: $0) }))

    var needed = [outputElement: outputAmount]
    var available = provided

    while let outputElement = needed.keys.first {
        var neededOutputAmount = needed[outputElement, default: 0]
        needed[outputElement] = nil // Remove existing amount because we're replacing it with the required inputs

        var availableOutputAmount = available[outputElement, default: 0]

        defer {
            available[outputElement] = availableOutputAmount
        }

        if availableOutputAmount >= neededOutputAmount {
            availableOutputAmount -= neededOutputAmount
        } else if neededOutputAmount > 0 {
            neededOutputAmount -= availableOutputAmount

            guard let reaction = reactionsByOutputElement[outputElement] else {
                // No reaction produces this element, and there is not enough available as raw ingredients, so the
                // reaction is not possible.
                return nil
            }

            let reactionCount = Int(ceil(Double(neededOutputAmount) / Double(reaction.outputAmount)))

            availableOutputAmount = (reaction.outputAmount * reactionCount - neededOutputAmount)

            reaction.inputs.forEach {
                needed[$0.key, default: 0] += $0.value * reactionCount
            }
        }
    }

    var inputs: [String: Int] = [:]
    var outputs = [outputElement: outputAmount]

    Set(provided.keys).union(available.keys).forEach { element in
        let oldValue = provided[element, default: 0]
        let newValue = available[element, default: 0]

        if oldValue > newValue {
            inputs[element, default: 0] += (oldValue - newValue)
        } else if oldValue < newValue {
            outputs[element, default: 0] += (newValue - oldValue)
        }
    }

    return MultiOutputReaction(inputs: inputs, outputs: outputs)
}

func maxProduction(of product: String, from provided: [String: Int], using reactions: [SingleOutputReaction]) -> Int {
    var lowerBound = 1
    var upperBound = 1

    while completeReaction(producing: upperBound, product, startingWith: provided, using: reactions) != nil {
        lowerBound = upperBound
        upperBound *= 2
    }

    while (lowerBound ..< upperBound).count > 1 {
        let mid = lowerBound + (upperBound - lowerBound) / 2

        if completeReaction(producing: mid, product, startingWith: provided, using: reactions) != nil {
            lowerBound = mid
        } else {
            upperBound = mid
        }
    }

    return lowerBound
}

func completeProduction(of product: String,
                        from provided: [String: Int],
                        using reactions: [SingleOutputReaction]) -> [String: Int] {

    var available = provided
    var produced = 0

    while let reaction = completeReaction(producing: 1, product, startingWith: available, using: reactions) {
        let reactionCount = reaction.inputs.map({ available[$0.key, default: 0] / $0.value }).min() ?? 0

        reaction.inputs.forEach {
            available[$0.key, default: 0] -= ($0.value * reactionCount)
        }

        reaction.outputs.forEach {
            available[$0.key, default: 0] += ($0.value * reactionCount)
        }

        assert(available.allSatisfy({ $0.value >= 0 }))

        // Remove target product so we can produce more of it:
        produced += available[product, default: 0]
        available[product] = 0
    }

    // Replace target product in result:
    available[product] = produced

    return available
}
