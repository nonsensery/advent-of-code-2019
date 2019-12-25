
struct NetworkIO {
    /// The special "NAT" address
    static let natAddress = 255

    private var buffers: [Int: ArraySlice<Int>] = [:]
    private var natPacket: Packet?
    private var activeAddresses: Set<Int> = []

    var isIdle: Bool {
        activeAddresses.isEmpty
    }

    mutating func connect(at address: Int) {
        // Using a fake packet to 'send' the address to the computer as the first input value.
        buffers[address, default: []].append(address)
    }

    mutating func send(_ packet: Packet) {
        if packet.source != Self.natAddress {
            activeAddresses.insert(packet.source)
        }

        if packet.destination == Self.natAddress {
            natPacket = packet
        } else {
            buffers[packet.destination, default: []].append(contentsOf: [packet.x, packet.y])
        }
    }

    mutating func receive(at address: Int) -> Int {
        if let value = buffers[address]?.popFirst() {
            activeAddresses.insert(address)
            return value
        } else {
            activeAddresses.remove(address)
            return -1
        }
    }

    mutating func receiveNATPacket() -> Packet? {
        defer { natPacket = nil }
        return natPacket
    }
}
