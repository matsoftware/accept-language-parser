import XCTest
import ALanguageParser

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

    //MARK: ALanguageParser
    func testParseShouldReturnExpectedOrderedLanguages() {

        let assertions: [(input: String, expectation: [AcceptedLanguage])] = [
            (input: "it-IT", expectation: [.itITW1]),
            (input: "it-IT,it;q=0.9,en-US;q=0.8,en;q=0.7,nn;q=0.6", expectation: [.itITW1, .itW09, .enUSW08, .enW07, .nnW06]),
            (input: "en-US,en;q=0.7", expectation: [.enUSW1, .enW07]),
            (input: "it-IT,zh-Hant-HK;q=0.5", expectation: [.itITW1, .zhHK]),
            (input: "it-IT,en-US", expectation: [.itITW1, .enUSW1]),
            (input: "en-US,*;q=0.9", expectation: [.enUSW1, .allW09]),
        ]

        assertions.forEach {
            XCTAssertEqual(ALanguageParser.parse($0.input), $0.expectation)
        }
    }

    static var allTests = [
        ("testParseShouldReturnExpectedOrderedLanguages", testParseShouldReturnExpectedOrderedLanguages),
    ]
}

// MARK: Tests support
extension AcceptedLanguage {

    static let itITW1 = AcceptedLanguage(code: "it", quality: 1.0, region: "IT", script: nil)
    static let itW09 = AcceptedLanguage(code: "it", quality: 0.9, region: nil, script: nil)
    static let enUSW1 = AcceptedLanguage(code: "en", quality: 1.0, region: "US", script: nil)
    static let enUSW08 = AcceptedLanguage(code: "en", quality: 0.8, region: "US", script: nil)
    static let enW07 = AcceptedLanguage(code: "en", quality: 0.7, region: nil, script: nil)
    static let nnW06 = AcceptedLanguage(code: "nn", quality: 0.6, region: nil, script: nil)
    static let zhHK = AcceptedLanguage(code: "zh", quality: 0.5, region: "HK", script: "Hant")
    static let allW09 = AcceptedLanguage(code: "*", quality: 0.9, region: nil, script: nil)

}
