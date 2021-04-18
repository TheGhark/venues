import UIKit

enum Font {
    case regular
    case medium

    func size(_ size: CGFloat) -> UIFont? {
        switch self {
        case .regular:
            return UIFont(name: "SFCompactDisplay-Regular", size: size)
        case .medium:
            return UIFont(name: "SFCompactDisplay-Medium", size: size)
        }
        
    }

}
