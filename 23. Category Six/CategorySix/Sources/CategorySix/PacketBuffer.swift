
struct Packet {
    var source: Int
    var destination: Int
    var x: Int
    var y: Int
}

enum PacketBuffer {
    case empty(source: Int)
    case partial1(source: Int, destination: Int)
    case partial2(source: Int, destination: Int, x: Int)
    case complete(Packet)

    mutating func append(_ value: Int) {
        switch self {
        case .empty(let source):
            self = .partial1(source: source, destination: value)
        case .partial1(let source, let destination):
            self = .partial2(source: source, destination: destination, x: value)
        case .partial2(let source, let destination, let x):
            self = .complete(Packet(source: source, destination: destination, x: x, y: value))
        case .complete:
            fatalError("Buffer overflow")
        }
    }
}
