import Foundation

struct VenueDto: Decodable {
    let imageUrl: String
    let cost: String
    let location: String
    let startTime: String
    let endTime: String

    enum CodingKeys: String, CodingKey {
        case imageUrl
        case cost
        case location
        case startTime = "start_time"
        case endTime = "end_time"
    }
}

extension VenueDto {
    func toDomain() -> Venue {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return .init(
            imageUrl: URL(string: imageUrl),
            cost: cost,
            location: location,
            startTime: dateFormatter.date(from: startTime),
            endTime: dateFormatter.date(from: endTime)
        )
    }
}
