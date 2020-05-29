import XCTest
@testable import ALanguageParser

final class ALanguageParserTests: XCTestCase {
    func testExample() {
        XCTAssertEqual(ALanguageParser().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
