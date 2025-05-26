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
  group('fetchFoodItemForProductCode tests', () {
    runTests();
  });
}

void runTests() {
  // Expected output: The returned food item name should be "Reduced Sugar Cinnamon Granola".
  test('Pass the "016000188853" as productCode', () async {
    await testWithFetchFoodItemForProductCode((result) async {
      expect(
          result?.name, equalsIgnoringCase('Reduced Sugar Cinnamon Granola'));
    });
  });

  // TODO: Needed to be fixed
  // Expected output: The returned food item name should be "Granola de Canela con Azúcar Reducida".
  test('Set the SDK language to "es" and pass "016000188853" as productCode',
      () async {
    await testWithLanguage((languageResult) async {
      expect(languageResult, isTrue);

      await testWithFetchFoodItemForProductCode((result) async {
        expect(
            result?.name, equalsIgnoringCase('Reduced Sugar Cinnamon Granola'));
      });
    });
  });

  // Expected output: The returned food item should be null because passioID is a food item.
  test('Pass the "VEG0018" as passioID', () async {
    final PassioFoodItem? result =
        await NutritionAI.instance.fetchFoodItemForProductCode('VEG0018');
    expect(result, isNull);
  });

  // Expected output: The returned food item should be null because passioID is invalid.
  test('Pass the "AAAAAAA" as passioID', () async {
    final PassioFoodItem? result =
        await NutritionAI.instance.fetchFoodItemForProductCode('AAAAAAA');
    expect(result, isNull);
  });

  test('Pass the "016000188853" as productCode without configureSDK', () async {
    await testWithoutConfigureSDK(() async {
      await testWithFetchFoodItemForProductCode((result) async {
        expect(result, isNull);
      });
    });
  });
}
