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
            return UIImage(named: "icn_camera")
        case .error:
            return UIImage(named: "icn_error")
        case .close:
            return UIImage(named: "icn_close")
        case .list:
            return UIImage(named: "icn_list")
        case .offline:
            return UIImage(named: "icn_offline")
        }
    }
}
