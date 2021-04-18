import XCTest
@testable import Venues
@testable import Components

final class VenuesViewModelTests: XCTestCase {
    var sut: VenuesViewModel!
    var venuesRepository: VenuesRepositoryMock!

    var reloadCalledCount: Int = 0
    var reloadHandler: (() throws -> Void)?
    var selectedTab: TabBarButton.Model?
    
    override func setUp() {
        super.setUp()
        venuesRepository = .init()
        sut = .init(
            venuesRepository: venuesRepository
        )
        sut.delegate = self
    }

    override func tearDown() {
        venuesRepository = nil
        reloadCalledCount = 0
        reloadHandler = nil
        sut = nil
        super.tearDown()
    }

    func test_numberOfSections_loading() {
        assert(numberOfSections: 1, lifecycleState: .didLoad)
    }

    func test_numberOfSections_empty() {
        venuesRepository.fetchVenuesMockFunc.returns(.success([]))
        assert(numberOfSections: 2, lifecycleState: .willAppear)
    }

    func test_numberOfSections_venues() {
        venuesRepository.fetchVenuesMockFunc.returns(.success([.sample()]))
        assert(numberOfSections: 1, lifecycleState: .willAppear)
    }

    func test_numberOfItems_loading() {
        assert(numberOfItems: 3, section: 0, lifecycleState: .didLoad)
    }

    func test_numberOfItems_empty_warning() {
        venuesRepository.fetchVenuesMockFunc.returns(.success([]))
        assert(numberOfItems: 1, section: 0, lifecycleState: .willAppear)
    }

    func test_numberOfItems_empty_venues() {
        venuesRepository.fetchVenuesMockFunc.returns(.success([]))
        assert(numberOfItems: 2, section: 1, lifecycleState: .willAppear)
    }

    func test_numberOfItems_venues() {
        venuesRepository.fetchVenuesMockFunc.returns(.success([.sample()]))
        assert(numberOfItems: 1, section: 0, lifecycleState: .willAppear)
    }

    func test_numberOfItems_error_warning() {
        venuesRepository.fetchVenuesMockFunc.returns(.failure(VenuesApiService.Error.noData))
        assert(numberOfItems: 1, section: 0, lifecycleState: .willAppear)
    }

    func test_numberOfItems_error_venues() {
        venuesRepository.fetchVenuesMockFunc.returns(.failure(VenuesApiService.Error.noData))
        assert(numberOfItems: 2, section: 1, lifecycleState: .willAppear)
    }

    func test_model_warning_error() throws {
        venuesRepository.fetchVenuesMockFunc.returns(.failure(VenuesApiService.Error.noData))
        try assert(warning: WarningCell.Model(type: .error, title: "title", subtitle: "subtitle", buttonModel: nil))
    }

    func test_model_warning_empty() throws {
        venuesRepository.fetchVenuesMockFunc.returns(.success([]))
        try assert(warning: WarningCell.Model(type: .empty, title: "title", subtitle: "subtitle", buttonModel: nil))
    }

    func test_model_warning_noConnection() throws {
        venuesRepository.fetchVenuesMockFunc.returns(.failure(VenuesApiService.Error.noConnection))
        try assert(
            warning: WarningCell.Model(type: .noConnection, title: "title", subtitle: "subtitle", buttonModel: nil)
        )
    }

    func test_model_loading() throws {
        sut.didChange(state: .didLoad)
        let model = try XCTUnwrap(sut.model(at: .init(row: 0, section: 0)) as? LoadingCell.Model)
        XCTAssertNotNil(model)
    }

    func test_model_venues() throws {
        venuesRepository.fetchVenuesMockFunc.returns(.success([.sample()]))
        let expectation = self.expectation(description: #function)
        reloadHandler = { [weak sut] in
            let model = try XCTUnwrap(sut?.model(at: .init(row: 0, section: 0)) as? VenueCell.Model)
            XCTAssertNotNil(model)
            expectation.fulfill()
        }
        sut.didChange(state: .willAppear)
        wait(for: [expectation], timeout: 0.1)
    }

    func test_otherLifecycleStates() {
        venuesRepository.fetchVenuesMockFunc.returns(.success([]))
        LifecycleState.allCases
            .forEach {
                sut.didChange(state: $0)
                switch $0 {
                case .didAppear, .willDisappear, .didDisappear:
                    XCTAssertEqual(reloadCalledCount, 2)
                case .didLoad, .willAppear:
                    // Already tested
                    break
                }
            }
    }

    func test_select_upcoming() {
        assert(selectTab: Localization.Tabbar.Button.upcoming)
    }

    func test_select_archived() {
        assert(selectTab: Localization.Tabbar.Button.archived)
    }

    func test_select_options() {
        assert(selectTab: Localization.Tabbar.Button.options)
    }
}

private extension VenuesViewModelTests {
    func assert(
        numberOfSections: Int,
        lifecycleState: LifecycleState,
        line: UInt = #line
    ) {
        let expectation = self.expectation(description: #function)
        reloadHandler = { [weak sut] in
            XCTAssertEqual(sut?.numberOfSections, numberOfSections)
            expectation.fulfill()
        }
        sut.didChange(state: lifecycleState)
        wait(for: [expectation], timeout: 0.1)
    }

    func assert(
        numberOfItems: Int,
        section: Int,
        lifecycleState: LifecycleState,
        line: UInt = #line
    ) {
        let expectation = self.expectation(description: #function)
        reloadHandler = { [weak sut] in
            XCTAssertEqual(sut?.numberOfItems(at: section), numberOfItems)
            expectation.fulfill()
        }
        sut.didChange(state: lifecycleState)
        wait(for: [expectation], timeout: 0.1)
    }

    func assert(
        warning: WarningCell.Model,
        line: UInt = #line
    ) throws {
        let expectation = self.expectation(description: #function)
        reloadHandler = { [weak sut] in
            let model = try XCTUnwrap(sut?.model(at: .init(row: 0, section: 0)) as? WarningCell.Model)
            XCTAssertEqual(model.type, warning.type)
            expectation.fulfill()
        }
        sut.didChange(state: .willAppear)
        wait(for: [expectation], timeout: 0.1)
    }

    func assert(
        selectTab title: String,
        line: UInt = #line
    ) {
        venuesRepository.fetchVenuesMockFunc.returns(.success([]))
        sut.didChange(state: .didLoad)
        if let model = sut.tabBarModel.buttons.first(where: { $0.title == title }) {
            model.action(model)
            XCTAssertEqual(selectedTab, model, line: line)
            XCTAssert(selectedTab?.selected == true, line: line)
        }
    }
}

extension VenuesViewModelTests: VenuesViewModelDelegate {
    func reload() {
        reloadCalledCount += 1
        do {
            try reloadHandler?()
        } catch {
            fatalError("`reloadHandler` must never fail")
        }
    }

    func select(tab: TabBarButton.Model?) {
        selectedTab = tab
    }
}
