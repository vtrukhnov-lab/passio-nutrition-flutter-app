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
  group('fetchMealPlans tests', () {
    runTests();
  });
}

void runTests() {
  // Expected output: Validate that the meal plan retrieval functionality fetches exactly 10 meal plans
  test('Retrieve All Meal Plans', () async {
    await testWithFetchMealPlans((result) async {
      expect(result.length, equals(10));
    });
  });

  // Expected output: Validate that the meal plan retrieval functionality fetches exactly 10 meal plans
  test('Set the SDK language to "es" and Retrieve All Meal Plans', () async {
    await testWithLanguage((languageResult) async {
      expect(languageResult, isTrue);

      await testWithFetchMealPlans((result) async {
        expect(result.length, equals(10));
      });
    });
  });

  // Expected output: The meal plan list should have both "keto" and "diabetes" items
  test(
      'Verify that the list of retrieved meal plans contains options labeled as "keto" and "diabetes."',
      () async {
    await testWithFetchMealPlans((result) async {
      expect(result.length, equals(10));
      expect(
          result,
          anyElement(
              (PassioMealPlan e) => e.mealPlanLabel.toLowerCase() == 'keto'));
      expect(
          result,
          anyElement((PassioMealPlan e) =>
              e.mealPlanLabel.toLowerCase() == 'diabetes'));
    });

    // final List<PassioMealPlan> result =
    //     await NutritionAI.instance.fetchMealPlans();
    // expect(result.length, equals(10));
    // expect(
    //     result,
    //     anyElement(
    //         (PassioMealPlan e) => e.mealPlanLabel.toLowerCase() == 'keto'));
    // expect(
    //     result,
    //     anyElement(
    //         (PassioMealPlan e) => e.mealPlanLabel.toLowerCase() == 'diabetes'));
  });

  test('Retrieve All Meal Plans without configureSDK', () async {
    await testWithoutConfigureSDK(() async {
      await testWithFetchMealPlans((result) async {
        expect(result, isEmpty);
      });
      // final List<PassioMealPlan> result =
      //     await NutritionAI.instance.fetchMealPlans();
      // expect(result, isEmpty);
    });
  });
}
