// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "ALanguageParser",
    products: [
        .library(
            name: "ALanguageParser",
            targets: ["ALanguageParser"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ALanguageParser",
            dependencies: []),
        .testTarget(
            name: "ALanguageParserTests",
            dependencies: ["ALanguageParser"])
    ]
)
