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
  group('fetchFoodItemLegacy tests', () {
    runTests();
  });
}

void runTests() {
  // Expected output: The returned food item name should be "apple".
  test('Pass "VEG0018" passioID that contains PassioFoodItem test', () async {
    final PassioFoodItem? result =
        await NutritionAI.instance.fetchFoodItemLegacy('VEG0018');
    expect(result?.name, equalsIgnoringCase('apple'));
  });

  /// TODO: Needed to be fixed
  // Expected output: The returned food item name should be "manzana".
  test(
      'Set the SDK language to "es" and pass "VEG0018" passioID that contains PassioFoodItem test',
      () async {
    await testWithLanguage((languageResult) async {
      expect(languageResult, isTrue);

      final PassioFoodItem? result =
          await NutritionAI.instance.fetchFoodItemLegacy('VEG0018');
      expect(result?.name, equalsIgnoringCase('manzana'));
    });
  });

  // Expected output: The returned food item should be null because "passioID" is invalid.
  test('Pass "AAAAAAAA" passioID that is not valid test', () async {
    final PassioFoodItem? result =
        await NutritionAI.instance.fetchFoodItemForRefCode('AAAAAAAA');
    expect(result, isNull);
  });

  test(
      'Pass "VEG0018" passioID that contains PassioFoodItem test without configureSDK',
      () async {
    await testWithoutConfigureSDK(() async {
      final PassioFoodItem? result =
          await NutritionAI.instance.fetchFoodItemLegacy('VEG0018');
      expect(result, isNull);
    });
  });
}
