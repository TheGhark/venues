import Foundation

public extension VenueCell {
    struct Model: ComponentModel {
        public let imageUrl: URL?
        public let cost: String
        public let location: String
        public let date: String
        public let venue: String
        public let timeslot: String

        public init(
            imageUrl: URL?,
            cost: String,
            location: String,
            date: String,
            venue: String,
            timeslot: String
        ) {
            self.imageUrl = imageUrl
            self.cost = cost
            self.location = location
            self.date = date
            self.venue = venue
            self.timeslot = timeslot
        }
    }
}
