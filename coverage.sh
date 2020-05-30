#!/bin/sh

set -e

swift test --enable-code-coverage

# Convert format
llvm-cov export -format="lcov" .build/debug/ALanguageParserPackageTests.xctest -instr-profile .build/debug/codecov/default.profdata > info.lcov