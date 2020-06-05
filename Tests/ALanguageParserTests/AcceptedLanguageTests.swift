//
//  AcceptedLanguageTests.swift
//  
//
//  Created by Mattia Campolese on 31/05/2020.
//

import XCTest
import ALanguageParser

final class AcceptedLanguageTests: XCTestCase {

    func testAcceptedLanguageEquatable() {
        let left = AcceptedLanguage(code: "it", quality: 1.0, region: "IT", script: "Latin")
        let right = AcceptedLanguage(code: "it", quality: 1.0, region: "IT", script: "Latin")
        XCTAssertEqual(left, right)
    }

    func testAcceptedLanguageCodable() throws {
        let baseAL = AcceptedLanguage(code: "nn", quality: 0.9, region: "NO", script: nil)
        let encAl = try JSONEncoder().encode(baseAL)
        let decAl = try JSONDecoder().decode(AcceptedLanguage.self, from: encAl)
        XCTAssertEqual(baseAL, decAl)
    }

    func testAcceptedLanguageExpressibleByStringLiteralValidRepresentation() {
        let acceptedLanguage: AcceptedLanguage = "zh-Hant-HK;q=0.5"
        XCTAssertEqual(acceptedLanguage, .zhHKW05)
    }

    func testAcceptedLanguageExpressibleByStringLiteralInValidRepresentation() {
        let acceptedLanguage: AcceptedLanguage = "any"
        XCTAssertEqual(acceptedLanguage, .any)
    }

    func testAcceptedLanguageCustomStringConvertible() {

        let assertions: [(input: String, expectation: AcceptedLanguage)] = [
            (input: "zh-Hant-HK;q=0.5", expectation: .zhHKW05),
            (input: "it-IT", expectation:  .itITW1),
            (input: "es", expectation: .esW1),
            (input: "it;q=0.9", expectation: .itW09),
            (input: "en-US;q=0.8", expectation: .enUSW08),
            (input: "el;q=0.35", expectation: .elW035)
        ]

        assertions.forEach {
            XCTAssertEqual($0.input, String(describing: $0.expectation))
        }

    }

    // MARK: Tests array

    static var allTests = [
        ("testAcceptedLanguageEquatable", testAcceptedLanguageEquatable),
        ("testAcceptedLanguageCodable", testAcceptedLanguageCodable),
        ("testAcceptedLanguageExpressibleByStringLiteralValidRepresentation",
         testAcceptedLanguageExpressibleByStringLiteralValidRepresentation),
        ("testAcceptedLanguageCustomStringConvertible", testAcceptedLanguageCustomStringConvertible)
    ]

}