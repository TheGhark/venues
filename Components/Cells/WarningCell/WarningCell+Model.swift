import UIKit

public extension WarningCell {
    struct Model: ComponentModel {
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
