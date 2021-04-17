@testable import Venues

final class MockFunc<Input, Output> {
    var parameters: [Input] = []
    var result: (Input) -> Output = { _ in fatalError() }
    var completions: [(Output) -> Void] = []
    var called: Bool = false
    var count: Int = 0

    func returns(_ value: Output) {
        result = { _ in value }
    }

    func call(_ input: Input) {
        parameters.append(input)
    }

    func callAndReturn(_ input: Input, completion: @escaping (Output) -> Void) {
        call(input)
        completions.append(completion)
        completion(result(input))
    }
}

final class VenuesApiServiceMock: VenuesApiServiceProtocol {
    var fetchVenuesMockFunc = MockFunc<(), (Result<[VenueDto], Error>)>()
    func fetchVenues(completion: @escaping (Result<[VenueDto], Error>) -> Void) {
        fetchVenuesMockFunc.callAndReturn((), completion: completion)
    }
}

final class VenuesRepositoryMock: VenuesRepositoryProtocol {
    var fetchVenuesMockFunc = MockFunc<(), (Result<[Venue], Error>)>()
    func fetchVenues(completion: @escaping (Result<[Venue], Error>) -> Void) {
        fetchVenuesMockFunc.callAndReturn((), completion: completion)
    }
}
