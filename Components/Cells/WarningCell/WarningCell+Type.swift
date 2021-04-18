import UIKit

extension WarningCell.Model {
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
}
