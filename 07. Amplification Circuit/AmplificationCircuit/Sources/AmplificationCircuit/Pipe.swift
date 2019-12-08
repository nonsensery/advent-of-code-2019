
public class Pipe<T> {
    private var buffer: ArraySlice<T> = []

    public func write(_ value: T) {
        buffer.append(value)
    }

    public func read() -> T? {
        buffer.popFirst()
    }
}
