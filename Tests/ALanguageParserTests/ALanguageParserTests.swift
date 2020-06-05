//
//  ALanguageParserTests.swift
//
//
//  Created by Mattia Campolese on 31/05/2020.
//

import XCTest
import ALanguageParser

final class ALanguageParserTests: XCTestCase {

    // MARK: ALanguageParser
    func testParseShouldReturnExpectedOrderedLanguages() {

        let assertions: [(input: String, expectation: [AcceptedLanguage])] = [
            (input: "it-IT", expectation: [.itITW1]),
            (input: "it-IT,it;q=0.9,en-US;q=0.8,en;q=0.7,nn;q=0.6",
             expectation: [.itITW1, .itW09, .enUSW08, .enW07, .nnW06]),
            (input: "en-US,en;q=0.7", expectation: [.enUSW1, .enW07]),
            (input: "it-IT,zh-Hant-HK;q=0.5", expectation: [.itITW1, .zhHKW05]),
            (input: "it-IT,en-US", expectation: [.itITW1, .enUSW1]),
            (input: "en-US,*;q=0.9", expectation: [.enUSW1, .allW09]),
            (input: "el;q=0.35", expectation: [.elW035])
        ]

        assertions.forEach {
            XCTAssertEqual(ALanguageParser.parse($0.input), $0.expectation)
        }
    }

    func testPickNotLooseShouldReturnExpectedOrderedLanguages() {

        let acceptLanguageExample = "it-IT,it;q=0.9,en-US;q=0.8,es;q=0.7,nn;q=0.6"

        let assertions: [(input: [AcceptedLanguage], expectation: String?)] = [
            (input: ["it", "it-IT", "zh"], expectation: "it-IT"),
            (input: ["no"], expectation: nil),
            (input: ["en"], expectation: nil)
        ]

        assertions.forEach {
            XCTAssertEqual(ALanguageParser.pick($0.input, acceptLanguage: acceptLanguageExample), $0.expectation)
        }

    }

    func testPickLooseShouldReturnExpectedOrderedLanguages() {

        let acceptLanguageExample = "it-IT,it;q=0.9,en-US;q=0.8,es;q=0.7,nn;q=0.6,fr-CA;q=0.5"

        let assertions: [(input: [AcceptedLanguage], expectation: String?)] = [
            (input: ["it", "it-IT", "zh"], expectation: "it"),
            (input: ["it-IT", "it", "zh"], expectation: "it-IT"),
            (input: ["fr"], expectation: "fr"),
            (input: ["fr-CA"], expectation: "fr-CA"),
            (input: ["no"], expectation: nil),
            (input: ["en"], expectation: "en")
        ]

        assertions.forEach {
            XCTAssertEqual(ALanguageParser.pick($0.input, acceptLanguage: acceptLanguageExample, loose: true),
                           $0.expectation)
        }

    }

    // MARK: Tests array
    static var allTests = [
        ("testParseShouldReturnExpectedOrderedLanguages", testParseShouldReturnExpectedOrderedLanguages),
        ("testPickNotLooseShouldReturnExpectedOrderedLanguages", testPickNotLooseShouldReturnExpectedOrderedLanguages),
        ("testPickLooseShouldReturnExpectedOrderedLanguages", testPickLooseShouldReturnExpectedOrderedLanguages)
    ]
}