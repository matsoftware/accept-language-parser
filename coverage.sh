#!/bin/sh

set -e

swift test --enable-code-coverage

# Convert format
llvm-cov export -format="lcov" .build/debug/ALanguageParserPackageTests.xctest -instr-profile .build/debug/codecov/default.profdata > info.lcov

# Code coverage
# request codecov to detect CI environment to pass through to docker
ci_env=`bash <(curl -s https://codecov.io/env)`
docker run $ci_env
# exec tests
bash <(curl -s https://codecov.io/bash)