public extension WarningCell {
    struct Model: ComponentModel {
        public enum WarningType {
            case empty
            case noConnection
            case error
        }

        public let type: WarningType

        public init(type: WarningType) {
            self.type = type
        }
    }
}
