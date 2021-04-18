import Components

protocol VenuesModelFactoryProtocol {
    func warningModel(
        type: WarningCell.Model.WarningType,
        action: (() -> Void)?
    ) -> WarningCell.Model
    func loadingModel() -> LoadingCell.Model
    func venueModel(with venue: Venue) -> VenueCell.Model
}

final class VenuesModelFactory {
    // MARK: - Properties
    
    private let dateFormatter: DateFormatter

    init(dateFormatter: DateFormatter = .init()) {
        self.dateFormatter = dateFormatter
    }
}

private extension VenuesModelFactory {
    func timeslot(from start: Date?, to end: Date?) -> String {
        guard  let start = start, let end = end else {
            return ""
        }
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        return "\(dateFormatter.string(from: start)) - \(dateFormatter.string(from: end))"
    }

    func date(from start: Date?) -> String {
        guard let start = start else { return "" }
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: start)
    }

    func warningInfo(with type: WarningCell.Model.WarningType) -> (title: String, subtitle: String) {
        switch type {
        case .empty:
            return (
                title: Localization.Warning.Empty.title,
                subtitle: Localization.Warning.Empty.subtitle
            )
        case .error:
            return (
                title: Localization.Warning.Error.title,
                subtitle: Localization.Warning.Error.subtitle
            )
        case .noConnection:
            return (
                title: Localization.Warning.Offline.title,
                subtitle: Localization.Warning.Offline.subtitle
            )
        }
    }
    
    func buttonModel(
        with type: WarningCell.Model.WarningType,
        action: (() -> Void)?
    ) -> Button.Model? {
        switch type {
        case .error, .noConnection:
            return .init(title: Localization.Common.Action.retry, action: action)
        case .empty:
            return nil
        }
    }
}

extension VenuesModelFactory: VenuesModelFactoryProtocol {
    func warningModel(
        type: WarningCell.Model.WarningType,
        action: (() -> Void)?
    ) -> WarningCell.Model {
        let info = warningInfo(with: type)
        return .init(
            type: type,
            title: info.title,
            subtitle: info.subtitle,
            buttonModel: buttonModel(with: type, action: action)
        )
    }
    
    func loadingModel() -> LoadingCell.Model {
        .init(icon: Icon.camera)
    }
    
    func venueModel(with venue: Venue) -> VenueCell.Model {
        .init(
            imageDownloader: ImageDownloader(url: venue.imageUrl),
            cost: venue.cost,
            location: venue.location,
            date: date(from: venue.startTime),
            venue: venue.name,
            timeslot: timeslot(from: venue.startTime, to: venue.endTime)
        )
    }
}
