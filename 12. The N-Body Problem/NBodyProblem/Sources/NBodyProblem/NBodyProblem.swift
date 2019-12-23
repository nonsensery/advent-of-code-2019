
func step(_ bodies: [Body]) {
    step(bodies.map({ $0.x }))
    step(bodies.map({ $0.y }))
    step(bodies.map({ $0.z }))
}

func step(_ vectors: [Vector]) {
    var remaining = ArraySlice(vectors)

    while let a = remaining.popFirst() {
        remaining.forEach { b in
            applyGravity(a, b)
        }
    }

    vectors.forEach({ $0.move() })
}

func totalEnergy(of bodies: [Body]) -> Int {
    bodies.map({ $0.totalEnergy }).reduce(0, +)
}

func stepsPerCycle(_ bodies: [Body]) -> Int {
    let xSteps = stepsPerCycle(of: bodies.map({ $0.x }))
    let ySteps = stepsPerCycle(of: bodies.map({ $0.y }))
    let zSteps = stepsPerCycle(of: bodies.map({ $0.z }))

    return leastCommonMultiple(xSteps, ySteps, zSteps)
}

private func stepsPerCycle(of vectors: [Vector]) -> Int {
    let initialState = vectors.map {
        Vector(position: $0.position, velocity: $0.velocity)
    }

    var steps = 0

    repeat {
        step(vectors)
        steps += 1
    } while vectors != initialState

    return steps
}

private func leastCommonMultiple(_ a: Int, _ b: Int, _ c: Int) -> Int {
    var a = a, b = b, c = c
    var i = 2

    while i < min(a, b, c) {
        while a % i == 0, b % i == 0, c % i == 0 {
            a = a / i
            b = b / i
            c = c / i
        }
        i += 1
    }

    return a * b * c
}
