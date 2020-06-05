//
//  AcceptedLanguage.swift
//  
//
//  Created by Mattia Campolese on 31/05/2020.
//

import Foundation

/// Type representing the accepted language returned from a parsed Accept-Language HTTP Header
public struct AcceptedLanguage: Equatable, Codable, ExpressibleByStringLiteral {

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

    /// AcceptedLanguage String Literal initializer
    /// - Parameter value: An accepted language in an Accept-Language valid string
    public init(stringLiteral value: StringLiteralType) {
        self.init(value)
    }

    init(_ rawString: String) {
        let components = rawString.split(separator: ";")
        let rawLocale = Locale(identifier: String(components.first ?? ""))
        let rawQuality = String(components.last ?? "1.0").replacingOccurrences(of: "q=", with: "")
        code = rawLocale.languageCode ?? ""
        region = rawLocale.regionCode
        script = rawLocale.scriptCode
        quality = Float(rawQuality) ?? 1.0
    }

}

// MARK: CustomStringConvertible
extension AcceptedLanguage: CustomStringConvertible {

    /// AcceptedLanguage description, reflection of the StringLiteral initialization.
    /// It will return a string in  RFC-2616 Accept-Language format
    /// (e.g. `it-IT;q=0.9`)
    public var description: String {
        [code, script, region]
            .compactMap { $0 }
            .joined(separator: "-")
            + qualityDescription
    }

    private var qualityDescription: String {
        quality < 1.0 ? ";q=\(String(format: "%1.5g", quality))" : ""
    }

}
