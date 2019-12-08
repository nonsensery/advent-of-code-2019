
public struct SpaceImage: Equatable {
    public let layers: [Layer]

    public init(layers: [Layer] = []) {
        self.layers = layers
    }

    public var width: Int {
        layers.first?.width ?? 0
    }

    public var height: Int {
        layers.first?.height ?? 0
    }

    public var checksum: Int {
        let rawLayers = layers
            .map {
                $0.pixels.flatMap({ $0 })
        }

        let rawLayerWithFewestZeros = rawLayers
            .min {
                $0.filter({ $0 == 0 }).count < $1.filter({ $0 == 0 }).count
            }
            ?? []

        let oneAndTwoCounts = rawLayerWithFewestZeros
            .reduce(into: [0, 0]) {
                $0[0] += ($1 == 1 ? 1 : 0)
                $0[1] += ($1 == 2 ? 1 : 0)
        }

        return oneAndTwoCounts.reduce(1, *)
    }

    public func flattened(transparent: Color? = nil) -> [[Int]] {
        (0 ..< height).map { row in
            (0 ..< width).map { col in
                layers
                    .lazy
                    .map({ $0.pixels[row][col] })
                    .first(where: { $0 != transparent })
                    ?? transparent!
            }
        }
    }

    //

    public typealias Color = Int

    public struct Layer: Equatable {
        public let pixels: [[Color]]

        public init(pixels: [[Color]] = []) {
            self.pixels = pixels
        }

        public var width: Int {
            pixels.first?.count ?? 0
        }

        public var height: Int {
            pixels.count
        }
    }
}

public extension SpaceImage {
    init(data: [Color], width: Int, height: Int) {
        let layerSize = width * height

        guard data.count % layerSize == 0 else {
            fatalError()
        }

        let layers = data
            .chunks(size: layerSize)
            .map({ Layer(pixels: $0.chunks(size: width)) })

        self.init(layers: layers)
    }
}
