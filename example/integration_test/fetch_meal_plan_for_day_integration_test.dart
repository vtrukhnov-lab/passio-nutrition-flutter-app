import 'package:flutter_test/flutter_test.dart';

import 'utils/sdk_utils.dart';

void main() {
  // This function is called once before all tests are run.
  setUpAll(() async {
    await configureSDK();
  });

  runGroup();
}

void runGroup() {
  group('fetchMealPlanForDay tests', () {
    runTests();
  });
}

void runTests() {
  // Expected output: Verify that the system retrieves the Day 4 meal plan for the keto diet, ensuring it includes meals specifically categorized under "Water" Plans
  test('Retrieve Day 4 Meal Plan for Keto Diet test', () async {
    await testWithFetchMealPlanForDay((result) async {
      expect(result, isNotNull);
      expect(result.first.dayTitle.toLowerCase(), 'day 1');
    });
  });

  // Expected output: Verify that the system retrieves the Day 1 meal plan for the keto diet, ensuring it includes meals specifically categorized under "Green Tea Plans
  test(
      'Set the SDK language to "es" and Retrieve Day 1 Meal Plan for Keto Diet test',
      () async {
    await testWithLanguage((languageResult) async {
      expect(languageResult, isTrue);

      await testWithFetchMealPlanForDay((result) async {
        expect(result, isNotNull);
        expect(result.first.dayTitle.toLowerCase(), 'day 1');
      });
    });
  });

  // Expected output: Validate that the system returns a null response when attempting to retrieve the Day 4 meal plan for the "XYZ Outside Meal" category, as it is expected to be unavailable
  test('Retrieve Day 4 Meal Plan for XYZ Outside Meal - Expect Null test',
      () async {
    await testWithFetchMealPlanForDay(mealPlan: 'XYZ', (result) async {
      expect(result, isEmpty);
    });
  });

  // TODO: This test is failed on iOS simulator.
  test('Retrieve Day 4 Meal Plan for Keto Diet without configureSDK test',
      () async {
    await testWithoutConfigureSDK(() async {
      await testWithFetchMealPlanForDay((result) async {
        expect(result, isEmpty);
      });
    });
  });
}
