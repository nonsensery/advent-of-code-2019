
public struct Location: Hashable {
    var x: Int
    var y: Int

    public init(x: Int = 0, y: Int = 0) {
        self.x = x
        self.y = y
    }
}
