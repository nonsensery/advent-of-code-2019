import Foundation

public enum Resource: String {
    case input_txt
    case sample1_txt
    case sample2_txt
    case sample3_txt

    private var name: String {
        String(rawValue.split(separator: "_")[0])
    }

    private var ext: String? {
        rawValue.split(separator: "_").last.map(String.init)
    }

    public var url: URL {
        Bundle.main.url(forResource: name, withExtension: ext)!
    }

    public var data: Data {
        try! Data(contentsOf: url)
    }

    public func text(encoding: String.Encoding = .utf8) -> String {
        String(data: data, encoding: encoding)!
    }

    public func values<V: LosslessStringConvertible>(encoding: String.Encoding = .utf8) -> [V] {
        text(encoding: encoding)
            .split(separator: ",")
            .map({ $0.trimmingCharacters(in: .whitespacesAndNewlines) })
            .map({ V(String($0))! })
    }
}
