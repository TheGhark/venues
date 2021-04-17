extension WarningCell {
    struct Model: ComponentModel {
        enum WarningType {
            case empty
            case noConnection
            case error
        }

        let type: WarningType
    }
}
