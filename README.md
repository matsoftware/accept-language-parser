# ALanguageParser

[![CircleCI](https://circleci.com/gh/matsoftware/accept-language-parser.svg?style=shield)](https://circleci.com/gh/matsoftware/accept-language-parser) [![codecov](https://codecov.io/gh/matsoftware/accept-language-parser/branch/master/graph/badge.svg)](https://codecov.io/gh/matsoftware/accept-language-parser) [![Codacy Badge](https://app.codacy.com/project/badge/Grade/ede74115487a4462860e7d7ce9f14db8)](https://www.codacy.com/manual/matsoftware/accept-language-parser?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=matsoftware/accept-language-parser&amp;utm_campaign=Badge_Grade) ![Cocoapods platforms](https://img.shields.io/cocoapods/p/ALanguageParser) [![Size](https://img.shields.io/github/languages/code-size/matsoftware/accept-language-parser)](Size) [![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fmatsoftware%2Faccept-language-parser.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fmatsoftware%2Faccept-language-parser?ref=badge_shield) [![License](https://img.shields.io/badge/license-MIT-blue.svg?x=1)](LICENSE)

<p align="center">
Lightweight HTTP RFC-2616 <b><a href="https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.4" target="_blank">Accept-Language</a></b> parser in Swift.
</p>

`ALanguageParser` is the swift porting of the npm [accept-language-parser](https://github.com/opentable/accept-language-parser) package by OpenTable.  It parses the accept-language header from an HTTP request and produces an array of language objects sorted by quality.

It has been designed to be used with Swift Server Side in mind (e.g. Vapor, Kitura, Perfect) but it can be used in any client side project.

## How to use

### Parse

It returns the ordered list of accepted languages:

```swift
import ALanguageParser

let languages = ALanguageParser.parse("it-IT,zh-Hant-HK;q=0.5")
```

The result will be:
```swift
[
    AcceptedLanguage(code: "it",
                     quality: 1.0,
                     region: "IT",
                     script: nil),

    AcceptedLanguage(code: "zh",
                     quality: 0.5,
                     region: "HK",
                     script: "Hant")
]
```

Output is always sorted in quality order from highest -> lowest. As per the HTTP spec, omitting the quality value implies `1.0`.

### Pick

Extracts the first selected language from the ones available in the given accept language string or `nil` if not present.

```swift
let language = ALanguageParser.pick(["fr-CA", "fr-FR", "fr"],
                                    acceptLanguage: "en-GB,en-US;q=0.9,fr-CA;q=0.7,en;q=0.8")
```

The output will be:
```swift
"fr-CA"
```

The function can be called with the `loose` parameter that allows partial matching on supported languages. For example:

```swift
let language = ALanguageParser.pick(["fr-CA", "fr-FR", "fr"],
                                    acceptLanguage: "en-GB,en-US;q=0.9,fr-CA;q=0.7,en;q=0.8",
                                    loose: true)
```

The output will be:
```swift
"fr"
```

In loose mode the order of `supportedLanguages` matters, as it is the first partially matching language that is returned. It means that if you want to pick more specific langauge first, you should list it first as well, for example: `["fr-CA", "fr"]`.

## Installation

### Swift Package Manager

The library, currently being developed in Swift 5.2, can be integrated by adding the following entry to your dependencies array in the `Package.swift` file:

```swift
.package(url: "https://github.com/matsoftware/accept-language-parser.git", from: "1.0.0")
```

Then in your target, please add the `ALanguageParser` dependency:

```swift
.product(name: "ALanguageParser", package: "ALanguageParser")
```

_Note: There's a current [issue](https://stackoverflow.com/questions/60943858/why-cant-i-use-swiftpm-as-a-dependency-using-swift-package-manager) with Swift Tools Version to 5.2. Please use 5.1 for the time being in your Package.json._

### CocoaPods

Add the pod `ALanguageParser` to your Podfile:

```ruby
pod 'ALanguageParser'
```

Run `pod install` and then open your workspace to launch Xcode.

## Contributions

Please open an issue on GitHub or fork the repository to make changes.

Before raising any PR, please make sure that the tests are passing on the _Linux_ platform. 

### Running the tests on Linux with Docker

You can use [Docker](https://docs.docker.com/get-docker/) to download the Swift image and perform tests on your MacOS/Windows machine.

Once Docker and its CLI are installed, you can get the image from [Docker Hub](https://hub.docker.com/_/swift) by running:

```bash
docker pull swift
```

Once the image has been download, from the root folder of your forked repository you can start the container in privileged mode and use a bind mount to let Docker access your folder:

```bash
docker run -it --privileged --mount type=bind,source=$(pwd),target=/app swift /bin/bash
```

Finally, you can run the tests:
```bash
root@c4706264baa1:/app$ swift test
```

## License
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fmatsoftware%2Faccept-language-parser.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Fmatsoftware%2Faccept-language-parser?ref=badge_large)

## Author

Created by [Mattia Campolese](https://www.linkedin.com/in/matcamp/).

[![Twitter Follow](https://img.shields.io/twitter/follow/matsoftware?style=social)](https://twitter.com/matsoftware)

Please also check out [swift code metrics](https://github.com/matsoftware/swift-code-metrics), the code metrics analyzer for Swift projects.