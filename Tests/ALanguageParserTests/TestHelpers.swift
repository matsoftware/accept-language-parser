//
//  TestHelpers.swift
//  
//
//  Created by Mattia Campolese on 31/05/2020.
//

import ALanguageParser
import XCTest

// MARK: AcceptedLanguage

extension AcceptedLanguage {

    static let itITW1 = AcceptedLanguage(code: "it", quality: 1.0, region: "IT", script: nil)
    static let itW09 = AcceptedLanguage(code: "it", quality: 0.9, region: nil, script: nil)
    static let enUSW1 = AcceptedLanguage(code: "en", quality: 1.0, region: "US", script: nil)
    static let enUSW08 = AcceptedLanguage(code: "en", quality: 0.8, region: "US", script: nil)
    static let enW07 = AcceptedLanguage(code: "en", quality: 0.7, region: nil, script: nil)
    static let nnW06 = AcceptedLanguage(code: "nn", quality: 0.6, region: nil, script: nil)
    static let esW1 = AcceptedLanguage(code: "es", quality: 1.0, region: nil, script: nil)
    static let zhHKW05 = AcceptedLanguage(code: "zh", quality: 0.5, region: "HK", script: "Hant")
    static let allW09 = AcceptedLanguage(code: "*", quality: 0.9, region: nil, script: nil)
    static let any = AcceptedLanguage(code: "any", quality: 1.0, region: nil, script: nil)
    static let elW035 = AcceptedLanguage(code: "el", quality: 0.35, region: nil, script: nil)

}
