
public func countPaintedPanels(program: Intcomputer.Program) -> Int {
    var op = PaintOperation(controller: IntcomputerPaintController(program: program))

    op.paint()

    return op.numberOfPaintedPanels
}

public func paintRegistrationNumber(program: Intcomputer.Program) -> String {
    var op = PaintOperation(controller: IntcomputerPaintController(program: program), paintedPanels: [.init(): .white])

    op.paint()

    return op.render()
}
