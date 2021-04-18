import UIKit

public enum Icon {
    case camera
    case error
    case close
    case list
    case offline

    public var image: UIImage? {
        switch self {
        case .camera:
            return UIImage(named: "icn_camera", in: .components, compatibleWith: nil)
        case .error:
            return UIImage(named: "icn_error", in: .components, compatibleWith: nil)
        case .close:
            return UIImage(named: "icn_close", in: .components, compatibleWith: nil)
        case .list:
            return UIImage(named: "icn_list", in: .components, compatibleWith: nil)
        case .offline:
            return UIImage(named: "icn_offline", in: .components, compatibleWith: nil)
        }
    }
}
