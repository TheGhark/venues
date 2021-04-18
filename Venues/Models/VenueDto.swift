import Foundation

struct VenueDto: Decodable {
    let imageUrl: String?
    let cost: String?
    let location: String?
    let name: String?
    let startTime: String?
    let endTime: String?

    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case cost
        case location
        case name = "venue"
        case startTime = "start_time"
        case endTime = "end_time"
    }
}

extension VenueDto {
    func toDomain() -> Venue? {
        guard
            let cost = cost,
            let location = location,
            let name = name,
            let startTime = startTime,
            let endTime = endTime
        else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD'T'HH:mm:ssZ"
        return .init(
            imageUrl: URL(string: imageUrl ?? ""),
            cost: cost,
            location: location,
            date: dateFormatter.date(from: startTime),
            name: name,
            startTime: dateFormatter.date(from: startTime),
            endTime: dateFormatter.date(from: endTime)
        )
    }
}
