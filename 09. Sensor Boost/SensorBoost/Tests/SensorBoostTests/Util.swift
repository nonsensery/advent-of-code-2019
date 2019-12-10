//
//  File.swift
//  
//
//  Created by Alex Johnson on 12/7/19.
//

import SensorBoost

func compute(program: Intcomputer.Program, input: [Intcomputer.Value] = []) throws -> [Intcomputer.Value] {
    let computer = Intcomputer(program: program)
    input.forEach(computer.input.write)

    while computer.isRunning {
        try computer.tick()
    }

    return Array(sequence(state: computer.output, next: { $0.read() }))
}
