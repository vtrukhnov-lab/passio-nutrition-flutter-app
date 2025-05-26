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
  group('fetchHiddenIngredients tests', () {
    runTests();
  });
}

void runTests() {
  // Expected output: The returned result should be success and not empty.
  test('Pass "apple" foodName that contains Hidden Ingredients test', () async {
    final PassioResult<List<PassioAdvisorFoodInfo>> result =
        await NutritionAI.instance.fetchHiddenIngredients('apple');
    switch (result) {
      case Success():
        expect(result.value, isNotEmpty);
        break;
      case Error():
        fail('Expected Success but got Error: ${result.message}');
    }
  });

  // Expected output: The returned result should be success and not empty.
  test(
      'Set the SDK language to "es" and pass "apple" foodName that contains Hidden Ingredients test',
      () async {
    await testWithLanguage((languageResult) async {
      expect(languageResult, isTrue);

      final PassioResult<List<PassioAdvisorFoodInfo>> result =
          await NutritionAI.instance.fetchHiddenIngredients('apple');
      switch (result) {
        case Success():
          expect(result.value, isNotEmpty);
          break;
        case Error():
          fail('Expected Success but got Error: ${result.message}');
      }
    });
  });

  // Expected output: The returned food item should be null because "passioID" is invalid.
  test('Pass "AAAAAAAA" foodName that is not valid test', () async {
    final PassioResult<List<PassioAdvisorFoodInfo>> result =
        await NutritionAI.instance.fetchHiddenIngredients('AAAAAAAA');
    switch (result) {
      case Success():
        fail('Expected Error but got Success: ${result.value}');
      case Error():
        expect(result.message, isNotEmpty);
    }
  });

  test(
      'Pass "apple" foodName that contains Hidden Ingredients test without configureSDK',
      () async {
    await testWithoutConfigureSDK(() async {
      final PassioResult<List<PassioAdvisorFoodInfo>> result =
          await NutritionAI.instance.fetchHiddenIngredients('apple');
      switch (result) {
        case Success():
          fail('Expected Error but got Success: ${result.value}');
        case Error():
          expect(result.message, isNotEmpty);
      }
    });
  });
}
