
func computeCyclicalBiodiversity(_ sim: Simulation) -> Int {
    var seen: Set<Int> = []
    var sim = sim

    while seen.insert(sim.biodiversity).inserted {
        sim.step()
    }

    return sim.biodiversity
}

func computePopulation(_ sim: Simulation2, after steps: Int) -> Int {
    var sim = sim

    (1...steps).forEach { _ in
        sim.step()
    }

    return sim.population
}
