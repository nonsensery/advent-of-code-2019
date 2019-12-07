import Foundation

public class MyPipe<T> {
    private let queue: DispatchQueue
    private let ready = DispatchSemaphore(value: 0)
    private var buffer: [T]

    init(label: String, contents: [T] = []) {
        queue = DispatchQueue(label: label)
        buffer = contents
    }

    public var label: String {
        queue.label
    }

    public func write(_ value: T) {
        print("\(label) writing \(value)")
        queue.sync { buffer.append(value) }
        ready.signal()
        print("... \(label) wrote")
    }

    public func read() -> T {
        print("\(label) reading...")
        ready.wait()
        let value = queue.sync { buffer.removeFirst() }
        print("... \(label) read \(value)")
        return value
    }
}
