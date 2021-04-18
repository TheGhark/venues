import UIKit

public extension WarningCell {
    struct Model: ComponentModel {
        public enum WarningType {
            case empty
            case noConnection
            case error

            var image: UIImage? {
                switch self {
                case .empty:
                    return Icon.list.image
                case .noConnection:
                    return Icon.offline.image
                case .error:
                    return Icon.error.image
                }
            }
        }

        public let type: WarningType
        let title: String
        let subtitle: String
        let buttonModel: Button.Model?

        public init(
            type: WarningType,
            title: String,
            subtitle: String,
            buttonModel: Button.Model?
        ) {
            self.type = type
            self.title = title
            self.subtitle = subtitle
            self.buttonModel = buttonModel
        }
    }
}
