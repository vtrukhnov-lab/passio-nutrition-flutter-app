#!/bin/bash

CURRENT_OS=${1:-"coverage"}

cd ../

flutter clean

flutter pub get

UNIT_TEST_COVERAGE_FILE_PATH=coverage/coverage.info

flutter test --no-test-assets --coverage --coverage-path $UNIT_TEST_COVERAGE_FILE_PATH

lcov --remove coverage/lcov.info "lib/src/models/passio_nutrition_facts.dart" "lib/src/extensions/*" "lib/src/converter/*" "lib/src/util/*" "lib/src/widgets/*" "lib/src/nutrition_advisor.dart" "lib/src/nutrition_ai_configuration.dart" "lib/src/nutrition_ai_detection.dart" "lib/src/nutrition_ai_method_channel.dart" "lib/src/nutrition_ai_platform_interface.dart" "lib/src/nutrition_ai_sdk.dart" -o coverage/lcov.info

CODE_COVERAGE=$(lcov --summary coverage/lcov.info 2>&1 | awk '/lines.*:/{print $2}' | tr -d '%')

#
echo "Total Code Coverage: $CODE_COVERAGE%"

# Integration Tests Coverage
#cd example
#
#COVERAGE_FILE_PATH=coverage/"${CURRENT_OS}".info
#
#flutter test integration_test/integration_test_runner.dart --coverage --coverage-package nutrition_ai --coverage-path "$COVERAGE_FILE_PATH"
#
#lcov --remove "$COVERAGE_FILE_PATH" "*/lib/src/nutrition_ai_platform_interface.dart" "*/lib/src/nutrition_ai_detection.dart" "*/lib/src/widgets/*" "*/lib/src/models/*" "lib/src/extensions/*" "lib/src/converter/*" -o "$COVERAGE_FILE_PATH"
#
#sed -i '' 's|SF:\.\./|SF:|g' "$COVERAGE_FILE_PATH"
#
#cd ../
#
#MERGED_FILE_PATH=coverage/merged.info
#MERGED_COVERAGE_PATH=coverage/merged/
#lcov --add-tracefile coverage/lcov.info -a example/"$COVERAGE_FILE_PATH" -o "$MERGED_FILE_PATH"
#
#### Exclude specific files from the existing lcov.info
##lcov --remove merged.info "lib/src/nutrition_ai_platform_interface.dart" "lib/src/models/passio_nutrition_facts.dart" "lib/src/converter/*" "lib/src/util/*" "lib/src/widgets/*" "lib/src/nutrition_advisor.dart" "lib/src/nutrition_ai_configuration.dart" "lib/src/nutrition_ai_detection.dart" "lib/src/nutrition_ai_method_channel.dart" "lib/src/nutrition_ai_platform_interface.dart" "lib/src/nutrition_ai_sdk.dart" -o coverage/lcov.info

#genhtml "$MERGED_FILE_PATH" -o "$MERGED_COVERAGE_PATH"
#
#open "$MERGED_COVERAGE_PATH"/index.html

# Generate HTML coverage report using lcov.info
#genhtml $COVERAGE_FILE_PATH -o coverage

# Open the generated HTML coverage report in the default web browser
#open coverage/index.html

# Remove the lcov.info file if you don't need it
# rm coverage/lcov.info


