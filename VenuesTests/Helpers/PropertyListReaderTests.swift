import XCTest
@testable import Venues

final class PropertyListReaderTests: XCTestCase {
    var sut: PropertyListReader!

    override func setUp() {
        super.setUp()
        
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_read_invalidFile() {
        makeSUT(filename: "asd")
        let info = sut.read()
        XCTAssertNil(info)
    }

    func test_read() {
        makeSUT()
        let info = sut.read()
        XCTAssertNotNil(info)
    }

    func test_read_id() {
        makeSUT()
        let info = sut.read()
        XCTAssertNotNil(info?["secret-key"])
    }
}

private extension PropertyListReaderTests {
    func makeSUT(filename: String = "Credentials") {
        sut = .init(filename: filename)
    }
}
