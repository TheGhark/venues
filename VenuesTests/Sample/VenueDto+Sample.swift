@testable import Venues

extension VenueDto {
    static func sample(
        imageUrl: String = "https://images.unsplash.com/photo-1582642017153-e36e8796b3f8",
        cost: String = "free",
        location: String = "The Penny Farthing",
        startTime: String = "2021-06-18T17:00:00Z",
        endTime: String = "2021-06-18T22:00:00Z"
    ) -> VenueDto {
        .init(
            imageUrl: imageUrl,
            cost: cost,
            location: location,
            startTime: startTime,
            endTime: endTime
        )
    }
}
