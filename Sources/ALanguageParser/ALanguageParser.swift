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
/// where  any two-letter primary-tag is an ISO-639 language abbreviation and any two-letter initial subtag is an ISO-3166 country code.
public struct ALanguageParser {

    private struct PreferredLanguage {
        var language: String
        var weight: Float

        init(_ rawString: String) {
            let comp = rawString.split(separator: ";")
            language = String(comp.first ?? "")
            let rawWeight = String(comp.last ?? "1.0").replacingOccurrences(of: "q=", with: "")
            weight = Float(rawWeight) ?? 1.0
        }
    }

    /// Parses and returns the list of user accepted languagges
    /// - Parameter acceptLanguage: A valid RFC-2616 Accept-Language string
    /// - Returns: an ordered list of languages parsed from the `acceptLanguage` string
    public static func parse(_ acceptLanguage: String) -> [String] {
        acceptLanguage.split(separator: ",").compactMap {
            PreferredLanguage(String($0))
        }.sorted {
            $0.weight > $1.weight
        }.map {
            $0.language
        }
    }

}
