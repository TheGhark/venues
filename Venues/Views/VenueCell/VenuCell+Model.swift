import Foundation

extension VenueCell {
    struct Model: ComponentModel {
        let imageUrl: URL?
        let cost: String
        let location: String
        let venue: String
        let timeslot: String
    }
}
