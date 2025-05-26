import 'package:flutter_test/flutter_test.dart';
import 'package:nutrition_ai/nutrition_ai.dart';

import 'utils/sdk_utils.dart';

void main() {
  setUpAll(() async {
    await configureSDK();
  });

  runGroup();
}

void runGroup() {
  group('updateLanguage tests', () {
    runTests();
  });
}

void runTests() {
  // Expected output: Returns true with supported language code.
  test('Pass valid language code "es"', () async {
    await testWithLanguage((result) async {
      expect(result, isTrue);
    });
  });

  // Expected output: Returns false with unsupported language code.
  test('Pass invalid language code "gj"', () async {
    await testWithLanguage(languageCode: 'gj', (result) async {
      expect(result, isFalse);
    });
  });

  /// Expected Output:
  /// 1. Language update to Hindi succeeds
  /// 2. Search results for "Apple" include the Hindi word "सेब"
  /// 3. Alternative names list includes the Hindi translation "सेब"
  test('Set SDK language to "hi", search for "Apple"', () async {
    await testWithLanguage(languageCode: 'hi', (result) async {
      expect(result, isTrue);

      final searchResult = await NutritionAI.instance.searchForFood('Apple');
      expect(
          searchResult.results,
          anyElement((PassioFoodDataInfo e) =>
              e.foodName.toLowerCase().contains('सेब')));
      expect(searchResult.alternateNames,
          anyElement((String e) => e.toLowerCase().contains('सेब')));
    });
  });

  // TODO: Not working on iOS.
  test('Pass valid language code "es" without configureSDK', () async {
    await testWithoutConfigureSDK(() async {
      await testWithLanguage((result) async {
        expect(result, isFalse);
      });
    });
  });
}
