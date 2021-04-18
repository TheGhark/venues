import Components
import XCTest
@testable import Venues

final class VenuesModelFactoryTests: XCTestCase {
    var sut: VenuesModelFactory!

    override func setUp() {
        super.setUp()
        sut = .init()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_warning_model_empty() {
        assert(
            warningType: .empty,
            title: Localization.Warning.Empty.title,
            subtitle: Localization.Warning.Empty.subtitle,
            buttonAction: nil
        )
    }

    func test_warning_model_error() {
        assert(
            warningType: .error,
            title: Localization.Warning.Error.title,
            subtitle: Localization.Warning.Error.subtitle
        )
    }

    func test_warning_model_offline() {
        assert(
            warningType: .noConnection,
            title: Localization.Warning.Offline.title,
            subtitle: Localization.Warning.Offline.subtitle
        )
    }

    func test_venue_model() {
        let start = Date()
        let end = start.addingTimeInterval(2 * 60 * 60)
        let venue = Venue.sample(
            startTime: start,
            endTime: end
        )
        let dateFormatter = DateFormatter()
        let model = sut.venueModel(with: venue)
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        XCTAssertEqual(
            model.date,
            dateFormatter.string(from: start)
        )
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        XCTAssertEqual(
            model.timeslot,
            "\(dateFormatter.string(from: start)) - \(dateFormatter.string(from: end))"
        )
    }
}

private extension VenuesModelFactoryTests {
    func assert(
        warningType: WarningCell.Model.WarningType,
        title: String,
        subtitle: String,
        buttonAction: String? = Localization.Common.Action.retry,
        line: UInt = #line
    ) {
        let model = sut.warningModel(type: warningType, action: nil)
        XCTAssertEqual(model.title, title, line: line)
        XCTAssertEqual(model.subtitle, subtitle, line: line)
        if let buttonAction = buttonAction {
            XCTAssertEqual(
                model.buttonModel,
                Button.Model(title: buttonAction, action: {}),
                line: line
            )
        }
    }
}
