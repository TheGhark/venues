import Foundation
@testable import Venues

extension Venue {
    static func sample(
        imageUrl: String = "https://images.unsplash.com/photo-1582642017153-e36e8796b3f8",
        cost: String = "free",
        location: String = "The Penny Farthing",
        name: String = "Manhattan",
        startTime: Date = .init(timeIntervalSinceNow: 0),
        endTime: Date = .init(timeIntervalSince1970: 10)
    ) -> Venue {
        .init(
            imageUrl: URL(string: imageUrl),
            cost: cost,
            location: location,
            name: name,
            startTime: startTime,
            endTime: endTime
        )
    }
}
