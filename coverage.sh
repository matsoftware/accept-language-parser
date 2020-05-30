#!/bin/zsh

set -e

# Run unit tests
# xcodebuild test \
#         -scheme ALanguageParser \
#         -destination platform="macOS" \
#         -enableCodeCoverage YES \
#         -derivedDataPath .build/derivedData
swift test --enable-code-coverage

# Convert format
xcrun llvm-cov export -format="lcov" .build/debug/ALanguageParserPackageTests.xctest/Contents/MacOS/ALanguageParserPackageTests -instr-profile .build/debug/codecov/default.profdata > info.lcov