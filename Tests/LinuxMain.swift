import XCTest

import ALanguageParserTests

var tests = [XCTestCaseEntry]()
tests += ALanguageParserTests.allTests()
tests += AcceptedLanguageTests.allTests()
XCTMain(tests)
