import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ALanguageParserTests.allTests),
        testCase(AcceptedLanguageTests.allTests)
    ]
}
#endif