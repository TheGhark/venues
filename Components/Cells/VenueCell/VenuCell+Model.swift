import Foundation

public extension VenueCell {
    struct Model: ComponentModel {
        public let imageDownloader: ImageDownloaderProtocol
        public let cost: String
        public let location: String
        public let date: String
        public let venue: String
        public let timeslot: String

        public init(
            imageDownloader: ImageDownloaderProtocol,
            cost: String,
            location: String,
            date: String,
            venue: String,
            timeslot: String
        ) {
            self.imageDownloader = imageDownloader
            self.cost = cost
            self.location = location
            self.date = date
            self.venue = venue
            self.timeslot = timeslot
        }
    }
}
