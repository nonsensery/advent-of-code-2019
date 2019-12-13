
public protocol _PaintOperationController {
    mutating func next(_ color: PaintOperation.Color) -> (PaintOperation.Color, PaintOperation.TurnDirection)?
}

public struct PaintOperation {
    public typealias Controller = _PaintOperationController

    private var controller: Controller
    private var robotOrientation: Orientation = .up
    private var robotLocation = Location()
    private var paintedPanels: [Location: Color] = [:]

    public enum TurnDirection: Int {
        case left = 0, right
    }

    private enum Orientation {
        case up, down, left, right
    }

    public enum Color: Int {
        case black = 0, white = 1
    }

    public init(controller: Controller, paintedPanels: [Location: Color] = [:]) {
        self.controller = controller
        self.paintedPanels = paintedPanels
    }

    private func observeSquare() -> Color {
        paintedPanels[robotLocation] ?? .black
    }

    private mutating func paintSquare(_ color: Color) {
        paintedPanels[robotLocation] = color
    }

    private mutating func turn(_ turnDirection: TurnDirection) {
        switch turnDirection {
        case .left:
            switch robotOrientation {
            case .up:
                robotOrientation = .left
            case .down:
                robotOrientation = .right
            case .left:
                robotOrientation = .down
            case .right:
                robotOrientation = .up
            }
        case .right:
            turn(.left)
            turn(.left)
            turn(.left)
        }
    }

    private mutating func moveForward() {
        switch robotOrientation {
        case .up:
            robotLocation.y -= 1
        case .down:
            robotLocation.y += 1
        case .left:
            robotLocation.x -= 1
        case .right:
            robotLocation.x += 1
        }
    }

    public mutating func paint() {
        while let (color, turnDirection) = controller.next(observeSquare()) {
            paintSquare(color)
            turn(turnDirection)
            moveForward()
        }
    }

    public func debugState(center: Location = Location(x: 0, y: 0), width: Int = 10, height: Int = 10) -> String {
        ((center.y - height/2) ... (center.y + height/2)).map { y in
            ((center.x - width/2) ... (center.x + width/2)).map { x in
                let location = Location(x: x, y: y)

                if location == robotLocation {
                    switch robotOrientation {
                    case .up:
                        return "^"
                    case .down:
                        return "v"
                    case .left:
                        return "<"
                    case .right:
                        return ">"
                    }
                }

                switch paintedPanels[location] ?? .black {
                case .black:
                    return "."
                case .white:
                    return "#"
                }
            }
            .joined()
        }
        .joined(separator: "\n")
    }

    public func render(padding: Int = 1) -> String {
        let whiteSquares = paintedPanels.filter({ $0.value == .white }).map({ $0.key })
        
        let minX = (whiteSquares.map({ $0.x }).min() ?? 0) - padding
        let maxX = (whiteSquares.map({ $0.x }).max() ?? 0) + padding
        let minY = (whiteSquares.map({ $0.y }).min() ?? 0) - padding
        let maxY = (whiteSquares.map({ $0.y }).max() ?? 0) + padding

        return
            (minY ... maxY).map { y in
                (minX ... maxX).map { x in
                    switch paintedPanels[Location(x: x, y: y)] ?? .black {
                    case .black:
                        return "⬛️"
                    case .white:
                        return "⬜️"
                    }
                }
                .joined()
            }
            .joined(separator: "\n")
    }

    public var numberOfPaintedPanels: Int {
        paintedPanels.count
    }
}

