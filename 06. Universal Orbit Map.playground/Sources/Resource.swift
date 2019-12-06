import Foundation

public enum Resource: String {
    case input_txt
    case sample1_txt
    case sample2_txt

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

    public func lines(encoding: String.Encoding = .utf8) -> [Substring] {
        text(encoding: encoding)
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .split(whereSeparator: { $0.isNewline })
    }
}
