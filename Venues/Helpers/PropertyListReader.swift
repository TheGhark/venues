import Foundation

protocol PropertyListReaderProtocol {
    func read() -> [String: String]?
}

final class PropertyListReader {
    // MARK: - Properties

    private let filename: String

    // MARK: - Initialization

    init(filename: String) {
        self.filename = filename
    }
}

extension PropertyListReader: PropertyListReaderProtocol {
    func read() -> [String: String]? {
        guard
            let path = Bundle.main.path(forResource: filename, ofType: "plist"),
            let contents = FileManager.default.contents(atPath: path)
        else {
            return nil
        }
        var format = PropertyListSerialization.PropertyListFormat.xml
        return try? PropertyListSerialization.propertyList(
            from: contents,
            options: .mutableContainersAndLeaves,
            format: &format
        ) as? [String: String]
    }
}
