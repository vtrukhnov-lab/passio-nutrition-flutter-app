import 'package:flutter_test/flutter_test.dart';

import 'utils/sdk_utils.dart';

void main() {
  setUpAll(() async {
    await configureSDK();
  });

  runGroup();
}

void runGroup() {
  group('fetchFoodItemForPassioID tests', () {
    runTests();
  });
}

void runTests() {
  // Expected output: The returned food item name should be "apple".
  /*test('Pass the "VEG0018" as passioID', () async {
    await testWithFetchFoodItemForPassioID((result) async {
      expect(result?.name, equalsIgnoringCase('apple'));
    });
  });

  // // TODO: Needed to be fixed
  // // Expected output: The returned food item name should be "manzana".
  test('Set the SDK language to "es" and pass "VEG0018" as passioID', () async {
    await testWithLanguage((languageResult) async {
      expect(languageResult, isTrue);

      await testWithFetchFoodItemForPassioID((result) async {
        expect(result?.name, equalsIgnoringCase('manzana'));
      });
    });
  });

  // Expected output: The returned food item should be null because passioID is a barcode.
  test('Pass the "681131018098" as passioID', () async {
    await testWithFetchFoodItemForPassioID(passioID: '681131018098',
        (result) async {
      expect(result, isNull);
    });
  });

  // Expected output: The returned food item should be null because passioID is invalid.
  test('Pass the "AAAAAAA" as passioID', () async {
    await testWithFetchFoodItemForPassioID(passioID: 'AAAAAAA', (result) async {
      expect(result, isNull);
    });
  });

  test('Pass the empty string as passioID test', () async {
    await testWithFetchFoodItemForPassioID(passioID: '', (result) async {
      expect(result, isNull);
    });
  });*/

  test('Pass the "VEG0018" as passioID without configureSDK', () async {
    await testWithoutConfigureSDK(() async {
      await testWithFetchFoodItemForPassioID((result) async {
        expect(result, isNull);
      });
    });
  });
}
