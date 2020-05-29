import XCTest
@testable import ALanguageParser

final class ALanguageParserTests: XCTestCase {

    //MARK: AcceptedLanguage
    func testAcceptedLanguageEquatable() {
        let left = AcceptedLanguage(code: "it", quality: 1.0, region: "IT", script: "Latin")
        let right = AcceptedLanguage(code: "it", quality: 1.0, region: "IT", script: "Latin")
        XCTAssertEqual(left, right)
    }

    func testAcceptedLanguageCodable() throws {
        let al = AcceptedLanguage(code: "nn", quality: 0.9, region: "NO", script: nil)
        let encAl = try JSONEncoder().encode(al)
        let decAl = try JSONDecoder().decode(AcceptedLanguage.self, from: encAl)
        XCTAssertEqual(al, decAl)
    }

    func testAcceptedLanguageComparable() {
        let left = AcceptedLanguage(code: "it", quality: 0.7, region: "IT", script: nil)
        let right = AcceptedLanguage(code: "no", quality: 1.0, region: "NN", script: nil)
        XCTAssertGreaterThan(right, left)
    }

    //MARK: Valid strings
    func testParseShouldReturnExpectedOrderedLanguages() {

        let assertions = [
            (input: "it-IT", expectation: ["it-IT"]),
            (input: "it-IT,it;q=0.9,en-US;q=0.8,en;q=0.7,es;q=0.6", expectation: ["it-IT", "it", "en-US","en", "es"]),
            (input: "en-US,en;q=0.8", expectation: ["en-US", "en"]),
            (input: "it,nn-NO;q=0.9,zh-Hant-HK;q=0.7", expectation: ["it", "nn-NO", "zh-Hant-HK"]),
        ]

        assertions.forEach {
            XCTAssertEqual(ALanguageParser.parse($0.input), $0.expectation)
        }
    }

    static var allTests = [
        ("testParseShouldReturnExpectedOrderedLanguages", testParseShouldReturnExpectedOrderedLanguages),
    ]
}
