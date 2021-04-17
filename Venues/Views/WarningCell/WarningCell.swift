import UIKit

final class WarningCell: UITableViewCell {
    // MARK: - Properties

    private var model: Model?

    // MARK: - Computed Properties

    var type: Model.WarningType? {
        model?.type
    }

    func update(with model: Model) {
        self.model = model
    }
}
