
func simulateNetwork(program: Intcomputer.Program) -> Int? {
    var computers = Array(repeating: Intcomputer(program: program), count: 50)
    var networkIO = NetworkIO()

    computers.indices.forEach { address in
        networkIO.connect(at: address)

        computers[address].input = {
            networkIO.receive(at: address)
        }

        var buffer: PacketBuffer = .empty(source: address)

        computers[address].output = {
            buffer.append($0)

            if case .complete(let packet) = buffer {
                buffer = .empty(source: address)
                networkIO.send(packet)
            }
        }
    }

    while computers.contains(where: { $0.isRunning }) {
        computers.indices.forEach {
            try! computers[$0].tick()
        }

        if let natPacket = networkIO.receiveNATPacket() {
            return natPacket.y
        }
    }

    return nil
}

func simulateNetworkWithNAT(program: Intcomputer.Program) -> Int? {
    var computers = Array(repeating: Intcomputer(program: program), count: 50)
    var networkIO = NetworkIO()

    computers.indices.forEach { address in
        networkIO.connect(at: address)

        computers[address].input = {
            networkIO.receive(at: address)
        }

        var buffer: PacketBuffer = .empty(source: address)

        computers[address].output = {
            buffer.append($0)

            if case .complete(let packet) = buffer {
                buffer = .empty(source: address)
                networkIO.send(packet)
            }
        }
    }

    var natYs: Set<Int> = []

    while computers.contains(where: { $0.isRunning }) {
        computers.indices.forEach {
            try! computers[$0].tick()
        }

        if networkIO.isIdle, let packet = networkIO.receiveNATPacket() {
            if !natYs.insert(packet.y).inserted {
                return packet.y
            }

            networkIO.send(Packet(source: NetworkIO.natAddress, destination: 0, x: packet.x, y: packet.y))
        }
    }

    return nil
}
