
func sumOfAlignmentParmeters(program: Intcomputer.Program) -> Int {
    let ascii = ASCII(program: program)
    let cameraOutput = ascii.queryCameras()

    return cameraOutput.scaffoldingLocations
        .filter {
            [$0.up, $0.down, $0.left, $0.right].allSatisfy(cameraOutput.scaffoldingLocations.contains)
        }
        .map {
            $0.x * $0.y
        }
        .reduce(0, +)
}
