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

    /// Parses and returns the list of user accepted languagges
    /// - Parameter acceptLanguage: A valid RFC-2616 Accept-Language string
    /// - Returns: an ordered list of `AcceptedLanguage` parsed from the `acceptLanguage` string
    public static func parse(_ acceptLanguage: String) -> [AcceptedLanguage] {
        acceptLanguage.split(separator: ",")
            .compactMap { AcceptedLanguage(String($0)) }
            .sorted { $0.quality > $1.quality }
    }

}

/// Type representing the accepted language returned from a parsed Accept-Language HTTP Header
public struct AcceptedLanguage: Equatable, Codable {
    /// Language code
    public var code: String
    /// The weight of this AcceptedLanguage in a list
    public var quality: Float
    /// The region of the accepted language
    public var region: String?
    /// The script code of the accepted language
    public var script: String?

    /// AcceptedLanguage designated initializer
    /// - Parameters:
    ///   - code: Language code
    ///   - quality: The weight of this AcceptedLanguage in a list
    ///   - region: The region of the accepted language
    ///   - script: The script code of the accepted language
    public init(code: String, quality: Float, region: String?, script: String?) {
        self.code = code
        self.quality = quality
        self.region = region
        self.script = script
    }

    fileprivate init(_ rawString: String) {
        let comp = rawString.split(separator: ";")
        let rawLocale = Locale(identifier: String(comp.first ?? ""))
        code = rawLocale.languageCode ?? ""
        region = rawLocale.regionCode
        script = rawLocale.scriptCode
        let rawQuality = String(comp.last ?? "1.0").replacingOccurrences(of: "q=", with: "")
        quality = Float(rawQuality) ?? 1.0
    }
}

extension AcceptedLanguage: Comparable {

    public static func < (lhs: AcceptedLanguage, rhs: AcceptedLanguage) -> Bool {
        lhs.quality < rhs.quality
    }

}
