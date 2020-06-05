//
//   ALanguageParser.swift
//
//
//  Created by Mattia Campolese on 29/05/2020.
//

import Foundation

/// HTTP RFC-2616 Accept-Language parser
/// https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.4
/// Language tags are defined by https://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.10
/// where :
///     - any two-letter primary-tag is an ISO-639 language abbreviation
///     - any two-letter initial subtag is an ISO-3166 country code.
public struct ALanguageParser {

    /// Parses and returns the list of user accepted languages
    /// - Parameter acceptLanguage: A valid RFC-2616 Accept-Language string
    /// - Returns: an ordered list of `AcceptedLanguage` parsed from the `acceptLanguage` string
    public static func parse(_ acceptLanguage: String) -> [AcceptedLanguage] {
        acceptLanguage.split(separator: ",")
            .compactMap { AcceptedLanguage(String($0)) }
            .sorted { $0.quality > $1.quality }
    }

    /// Extract the selected language from the given Accept-Language string
    /// - Parameters:
    ///   - supportedLanguages: The languages to pick from
    ///   - acceptLanguage: A valid RFC-2616 Accept-Language string
    ///   - loose: option that allows partial matching on supported languages. 
    /// - Returns: The first supported language in the acceptLanguage, nil if there's no match
    public static func pick(_ supportedLanguages: [AcceptedLanguage],
                            acceptLanguage: String,
                            loose: Bool = false) -> String? {
        let parsedLanguages = parse(acceptLanguage)
        //  The order of supportedLanguages matters
        let (initialArray, matchingArray): ([AcceptedLanguage], [AcceptedLanguage]) =
            loose ? (supportedLanguages, parsedLanguages) : (parsedLanguages, supportedLanguages)
            return extractFirstOccurrence(from: initialArray, matching: matchingArray, loose: loose)
    }

    private static func extractFirstOccurrence(from initialArray: [AcceptedLanguage],
                                               matching: [AcceptedLanguage],
                                               loose: Bool) -> String? {
        if let pickedLanguage = initialArray.first (where: {
            matching.doesContain($0, loose: loose)
        }) {
            return String(describing: pickedLanguage)
        } else {
            return nil
        }
    }

}

// MARK: Helpers
extension Array where Element == AcceptedLanguage {

    func doesContain(_ element: AcceptedLanguage, loose: Bool) -> Bool {
        contains {
            let sameCode = element.code == $0.code
            if loose {
                return sameCode
            } else {
                return sameCode &&
                element.region == $0.region &&
                element.script == $0.script
            }

        }
    }

}