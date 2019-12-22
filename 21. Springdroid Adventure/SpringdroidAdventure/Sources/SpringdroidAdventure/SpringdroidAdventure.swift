
func assessHullDamage(program: ASCIIComputer.Program, script: String, debug: Bool = false) -> Int? {
    let computer = ASCIIComputer(program: program)
    var input = ArraySlice(script.split(separator: "\n").map(String.init))
    var result: Int?

    computer.inputLine = {
        input.popFirst()
    }

    if !debug {
        computer.outputLine = { _ in }
    }

    computer.outputNonASCII = {
        result = $0
    }

    try! computer.run()

    return result
}
