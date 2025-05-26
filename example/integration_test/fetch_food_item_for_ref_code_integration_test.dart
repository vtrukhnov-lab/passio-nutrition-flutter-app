import 'package:flutter_test/flutter_test.dart';

import 'utils/sdk_utils.dart';

void main() {
  setUpAll(() async {
    await configureSDK();
  });

  runGroup();
}

void runGroup() {
  group('fetchFoodItemForRefCode tests', () {
    runTests();
  });
}

void runTests() {
  // Expected output: The returned food item name should be "apple".
  test('Pass "refCode" that contains PassioFoodItem test', () async {
    await testWithFetchFoodItemForRefCode((result) async {
      expect(result?.name, equalsIgnoringCase('apple'));
    });
  });

  // Expected output: The returned food item name should be "manzana".
  test(
      'Set the SDK language to "es" and pass "refCode" that contains PassioFoodItem test',
      () async {
    await testWithLanguage((languageResult) async {
      expect(languageResult, isTrue);

      await testWithFetchFoodItemForRefCode((result) async {
        expect(result?.name, equalsIgnoringCase('manzana'));
      });
    });
  });

  // Expected output: The returned food item should be null because "refCode" is invalid.
  test('Pass "refCode" that is not valid test', () async {
    await testWithFetchFoodItemForRefCode(refCode: 'AAAAAAAA', (result) async {
      expect(result, isNull);
    });
  });

  test('Pass "refCode" that contains PassioFoodItem test without configureSDK',
      () async {
    await testWithoutConfigureSDK(() async {
      await testWithFetchFoodItemForRefCode((result) async {
        expect(result, isNull);
      });
    });
  });
}
