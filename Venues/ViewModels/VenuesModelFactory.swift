import Components

protocol VenuesModelFactoryProtocol {
    func warningModel(type: WarningCell.Model.WarningType) -> WarningCell.Model
    func loadingModel() -> LoadingCell.Model
    func venueModel(with venue: Venue) -> VenueCell.Model
}

final class VenuesModelFactory {
    // MARK: - Properties

    private let dateFormatter: DateFormatter

    init(dateFormatter: DateFormatter = .init()) {
        self.dateFormatter = dateFormatter
        dateFormatter.timeStyle = .short
    }
}

private extension VenuesModelFactory {
    func timeslot(from start: Date?, to end: Date?) -> String {
        guard  let start = start, let end = end else {
            return ""
        }
        return "\(dateFormatter.string(from: start)) - \(dateFormatter.string(from: end))"
    }
}

extension VenuesModelFactory: VenuesModelFactoryProtocol {
    func warningModel(type: WarningCell.Model.WarningType) -> WarningCell.Model {
        .init(type: type)
    }
    
    func loadingModel() -> LoadingCell.Model {
        .init()
    }
    
    func venueModel(with venue: Venue) -> VenueCell.Model {
        .init(
            imageUrl: venue.imageUrl,
            cost: venue.cost,
            location: venue.location,
            venue: venue.name,
            timeslot: timeslot(from: venue.startTime, to: venue.endTime)
        )
    }
}
