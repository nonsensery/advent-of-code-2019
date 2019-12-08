//
//  File.swift
//  
//
//  Created by Alex Johnson on 12/7/19.
//

import AmplificationCircuit

// Workaround for `Foundation.Pipe` ambiguity
typealias Pipe = AmplificationCircuit.Pipe

extension Computer {
    convenience init(instructions: ComputeValue...) {
        let program = Array(instructions) + Array(repeating: 0, count: 256 - instructions.count)

        self.init(program: program)
    }
}
