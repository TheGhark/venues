import Foundation

protocol VenuesApiServiceProtocol {
    func fetchVenues(completion: @escaping (Result<[VenueDto], Swift.Error>) -> Void)
}

final class VenuesApiService {
    enum Error: Swift.Error {
        case invalidUrl
        case noData
        case noConnection
    }

    // MARK: - Properties

    private let session: URLSession
    private let decoder: JSONDecoder
    private let propertyListReader: PropertyListReaderProtocol

    // MARK: - Initialization

    init(
        session: URLSession = .shared,
        decoder: JSONDecoder = .init(),
        propertyListReader: PropertyListReaderProtocol = PropertyListReader(filename: "Credentials")
    ) {
        self.session = session
        self.decoder = decoder
        self.propertyListReader = propertyListReader
    }
}

extension VenuesApiService: VenuesApiServiceProtocol {
    func fetchVenues(completion: @escaping (Result<[VenueDto], Swift.Error>) -> Void) {
        guard
            let url = URL(string: "https://api.jsonbin.io/b/6050a8a3683e7e079c519892"),
            let properties = propertyListReader.read(),
            let secretKey = properties["secret-key"]
        else {
            completion(.failure(Error.invalidUrl))
            return
        }

        var request = URLRequest(url: url)
        request.addValue(secretKey, forHTTPHeaderField: "secret-key")
        let task = session.dataTask(with: request) { data, _, error in
            if let error = error {
                if (error as NSError).code == -1009 {
                    completion(.failure(Error.noConnection))
                } else {
                    completion(.failure(error))
                }
            } else if let data = data {
                do {
                    let venues = try self.decoder.decode([VenueDto].self, from: data)
                    completion(.success(venues))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(Error.noData))
            }
        }
        task.resume()
    }
}
