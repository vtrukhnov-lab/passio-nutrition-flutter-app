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
  group('fetchUltraProcessingFoodRating tests', () {
    runTests();
  });
}

void runTests() {
  PassioFoodItem? barcodeFoodItemResult;

  // Expected Output: Result must be success, and chainOfThought should contain reasoning.
  test('Fetch UPF rating for a visual food item test', () async {
    await testWithFetchFoodItemForPassioID((foodItem) async {
      if (foodItem == null) {
        fail('Failed to fetch food item for refCode');
      }
      await testWithFetchUltraProcessingFoodRating(foodItem: foodItem,
          (result) async {
        switch (result) {
          case Success():
            expect(result.value.chainOfThought, isNotEmpty);
            expect(result.value.highlightedIngredients, isEmpty);
            expect(result.value.rating, greaterThanOrEqualTo(0));
            break;
          case Error():
            fail('Expected Success but got Error: ${result.message}');
        }
      });
    });
  });

  // Expected Output: Result must be non-null, chainOfThought and ingredients should not be empty, and rating should be >= 0.
  test('Fetch UPF rating for a barcode item test', () async {
    await testWithFetchFoodItemForProductCode((foodItem) async {
      if (foodItem == null) {
        fail('Failed to fetch food item for refCode');
      }
      barcodeFoodItemResult = foodItem;
      await testWithFetchUltraProcessingFoodRating(foodItem: foodItem,
          (result) async {
        switch (result) {
          case Success():
            expect(result.value, isNotNull);
            expect(result.value.chainOfThought, isNotEmpty);
            expect(result.value.highlightedIngredients, isNotEmpty);
            expect(result.value.rating, greaterThanOrEqualTo(0));
            break;
          case Error():
            fail('Expected Success but got Error: ${result.message}');
        }
      });
    });
  });

  test(
      'Set the SDK language to "es" and fetch UPF rating for a barcode item test',
      () async {
    await testWithLanguage((languageResult) async {
      expect(languageResult, isTrue);

      await testWithFetchUltraProcessingFoodRating(
          foodItem: barcodeFoodItemResult!, (result) async {
        switch (result) {
          case Success():
            expect(result.value, isNotNull);
            expect(result.value.chainOfThought, isNotEmpty);
            expect(result.value.highlightedIngredients, isNotEmpty);
            expect(result.value.rating, greaterThanOrEqualTo(0));
            break;
          case Error():
            fail('Expected Success but got Error: ${result.message}');
        }
      });
    });
  });

  test('Fetch UPF rating for a barcode item without configureSDK', () async {
    await testWithoutConfigureSDK(() async {
      await testWithFetchUltraProcessingFoodRating(
          foodItem: barcodeFoodItemResult!, (result) async {
        switch (result) {
          case Success():
            fail('Expected Error but got Success: ${result.value}');
          case Error():
            expect(result.message, isNotEmpty);
        }
      });
    });
  });
}
