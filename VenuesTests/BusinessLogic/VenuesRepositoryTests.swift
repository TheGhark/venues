import XCTest
@testable import Venues

final class VenuesRepositoryTests: XCTestCase {
    var sut: VenuesRepository!
    var service: VenuesApiServiceMock!

    override func setUp() {
        super.setUp()
        service = .init()
        sut = .init(service: service)
    }

    override func tearDown() {
        service = nil
        sut = nil
        super.tearDown()
    }

    func test_fetchVenues() {
        service.fetchVenuesMockFunc.returns(.success([.sample()]))
        let expectation = self.expectation(description: #function)
        sut.fetchVenues { result in
            expectation.fulfill()
            switch result {
            case let .success(venues):
                XCTAssertEqual(venues.count, 1)
            case .failure:
                XCTFail("The service must return one venue")
            }
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func test_fetchVenues_failure() {
        service.fetchVenuesMockFunc.returns(.failure(VenuesApiService.Error.noData))
        let expectation = self.expectation(description: #function)
        sut.fetchVenues { result in
            expectation.fulfill()
            switch result {
            case .success:
                XCTFail("The service must not return venues")
            case let .failure(error):
                XCTAssertTrue(error is VenuesApiService.Error)
            }
        }
        wait(for: [expectation], timeout: 0.1)
    }
}
