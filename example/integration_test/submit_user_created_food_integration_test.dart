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
  group('submitUserCreatedFood tests', () {
    runTests();
  });
}

void runTests() {
  PassioFoodItem? foodItem;
  // Expected output: Verify that the result should be success and the value should be true.
  test('Pass PassioFoodItem to submitUserCreatedFood', () async {
    foodItem = await NutritionAI.instance.fetchFoodItemForPassioID('VEG0018');
    expect(foodItem, isNotNull);
    final PassioResult<bool> result =
        await NutritionAI.instance.submitUserCreatedFood(foodItem!);
    switch (result) {
      case Success():
        expect(result.value, isTrue);
        break;
      case Error():
        fail('Expected Success but got Error: ${result.message}');
    }
  });

  // Expected output: Verify that the result should be success and the value should be true.
  test(
      'Set the SDK language to "es" and pass PassioFoodItem to submitUserCreatedFood',
      () async {
    await testWithLanguage((languageResult) async {
      expect(languageResult, isTrue);

      final PassioFoodItem? foodItem =
          await NutritionAI.instance.fetchFoodItemForPassioID('VEG0018');
      expect(foodItem, isNotNull);
      final PassioResult<bool> result =
          await NutritionAI.instance.submitUserCreatedFood(foodItem!);
      switch (result) {
        case Success():
          expect(result.value, isTrue);
          break;
        case Error():
          fail('Expected Success but got Error: ${result.message}');
      }
    });
  });

  test('Pass PassioFoodItem to submitUserCreatedFood without configureSDK',
      () async {
    await testWithoutConfigureSDK(() async {
      final PassioResult<bool> result =
          await NutritionAI.instance.submitUserCreatedFood(foodItem!);
      switch (result) {
        case Success():
          expect(result.value, isTrue);
          break;
        case Error():
          fail('Expected Success but got Error: ${result.message}');
      }
    });
  });
}
