import Foundation

protocol VenuesRepositoryProtocol {
    func fetchVenues(completion: @escaping (Result<[Venue], Error>) -> Void)
}

final class VenuesRepository {
    // MARK: - Properties

    private let service: VenuesApiServiceProtocol

    // MARK: - Initialization

    init(service: VenuesApiServiceProtocol = VenuesApiService()) {
        self.service = service
    }
}

extension VenuesRepository: VenuesRepositoryProtocol {
    func fetchVenues(completion: @escaping (Result<[Venue], Error>) -> Void) {
        service.fetchVenues { result in
            DispatchQueue.main.async {
                completion(
                    result.map { dtos in
                        dtos.compactMap { $0.toDomain() }
                    }
                )
            }
        }
    }
}
