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
  group('fetchSuggestions tests', () {
    runTests();
  });
}

void runTests() {
  // Expected output: Verify that the breakfast suggestion API correctly processes the request and returns "Coffee" as a suggestion, with its calorie count specified as 2 kcal
  test('Pass Breakfast Suggestion - Return Coffee with 2 Kcal test', () async {
    await testWithFetchSuggestions((result) async {
      expect(result, isNotEmpty);
      expect(
          result,
          anyElement((PassioFoodDataInfo element) =>
              element.foodName.toLowerCase() == 'coffee'));
      expect(
          result,
          anyElement((PassioFoodDataInfo element) =>
              element.nutritionPreview.calories == 2));
    });
  });

  // Expected output: Verify that the lunch suggestion API correctly processes the request and returns keyword with "rice" as a suggestion, with its calorie count specified as arround 200 (50) kcal
  test('Pass Lunch Suggestion - Return Rice with around 204 Kcal', () async {
    await testWithFetchSuggestions(mealTime: PassioMealTime.lunch,
        (result) async {
      expect(result, isNotEmpty);
      expect(
          result,
          anyElement((PassioFoodDataInfo element) =>
              element.foodName.toLowerCase() == 'cooked white rice'));
      expect(
          result,
          anyElement((PassioFoodDataInfo element) =>
              element.nutritionPreview.calories == 204));
    });
  });

  // Expected output: Verify that the dinner suggestion API correctly processes the request and returns keyword with "rice" as a suggestion, with its calorie count specified as arround 200 (50) kcal
  test('Pass Dinner Suggestion - Return Coffee with 204 Kcal', () async {
    await testWithFetchSuggestions(mealTime: PassioMealTime.dinner,
        (result) async {
      expect(result, isNotEmpty);
      expect(
          result,
          anyElement((PassioFoodDataInfo element) =>
              element.foodName.toLowerCase() == 'cooked white rice'));
      expect(
          result,
          anyElement((PassioFoodDataInfo element) =>
              element.nutritionPreview.calories == 204));
    });
  });

  // Expected output: Verify that the Snack suggestion API correctly processes the request and returns "banana" as a suggestion, with its calorie count specified as 200 kcal
  test('Pass Snack Suggestion - Return Banana with 200 Kcal', () async {
    await testWithFetchSuggestions(mealTime: PassioMealTime.snack,
        (result) async {
      expect(result, isNotEmpty);
      expect(
          result,
          anyElement((PassioFoodDataInfo element) =>
              element.foodName.toLowerCase() == 'banana'));
    });
  });

  test(
      'Pass Breakfast Suggestion - Return Coffee with 2 Kcal without configureSDK',
      () async {
    await testWithoutConfigureSDK(() async {
      await testWithFetchSuggestions((result) async {
        expect(result, isEmpty);
      });
    });
  });
}
