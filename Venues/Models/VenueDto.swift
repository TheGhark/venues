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
    func toDomain() -> Venue? {
        let dateFormatter = DateFormatter()
        guard
            let imageUrl = URL(string: imageUrl),
            let startTime = dateFormatter.date(from: startTime),
            let endTime = dateFormatter.date(from: endTime)
        else {
            return nil
        }
        
        return .init(
            imageUrl: imageUrl,
            cost: cost,
            location: location,
            startTime: startTime,
            endTime: endTime
        )
    }
}
