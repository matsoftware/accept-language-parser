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

}
