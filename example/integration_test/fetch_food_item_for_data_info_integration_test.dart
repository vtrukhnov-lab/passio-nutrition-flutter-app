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
  group('fetchFoodItemForDataInfo tests', () {
    runTests();
  });
}

void runTests() {
  // Expected output: The test should confirm that searching for "Apple" correctly identifies and retrieves a food item specifically named "apple".
  test('fetches the PassioFoodItem correctly.', () async {
    await testWithSearchForFood((PassioSearchResponse searchResult) async {
      final PassioFoodDataInfo foodDataInfo = searchResult.results.firstWhere(
          (e) => e.foodName.toLowerCase() == 'apple',
          orElse: () => throw Exception(
              'No food item named "apple" found in the search results.'));
      final PassioFoodItem? result =
          await NutritionAI.instance.fetchFoodItemForDataInfo(foodDataInfo);
      expect(result?.name, equalsIgnoringCase('apple'),
          reason: 'The food item returned should have the name "apple".');
    });
  });

  // Expected output: The test should confirm that searching for "Reduced Sugar Cinnamon Granola" correctly identifies and retrieves a food item specifically named "reduced sugar cinnamon granola".
  test(
      'Verify that searching for "Reduced Sugar Cinnamon Granola" returns a result named "reduced sugar cinnamon granola" and fetches the PassioFoodItem correctly.',
      () async {
    await testWithSearchForFood(searchTerm: 'Reduced Sugar Cinnamon Granola',
        (PassioSearchResponse searchResult) async {
      final PassioFoodDataInfo foodDataInfo = searchResult.results.firstWhere(
          (e) => e.foodName.toLowerCase() == 'reduced sugar cinnamon granola',
          orElse: () => throw Exception(
              'No food item named "Reduced Sugar Cinnamon Granola" found in the search results.'));

      final PassioFoodItem? result =
          await NutritionAI.instance.fetchFoodItemForDataInfo(foodDataInfo);
      expect(result?.name, equalsIgnoringCase('Reduced Sugar Cinnamon Granola'),
          reason:
              'The food item returned should have the name "Reduced Sugar Cinnamon Granola".');
    });
  });

  // Expected output: Verify that the "manzana" food item can be retrieved correctly in Spanish using its associated food data info from search results.
  test(
      'Set the SDK language to "es" and retrieve the food item "manzana" using specific food data info and verify its name.',
      () async {
    await testWithLanguage((languageResult) async {
      expect(languageResult, isTrue);
      await testWithSearchForFood(searchTerm: 'manzana',
          (PassioSearchResponse searchResult) async {
        final PassioFoodDataInfo foodDataInfo = searchResult.results.firstWhere(
            (e) => e.foodName.toLowerCase().startsWith('manzana'),
            orElse: () => fail(
                'No food item named "manzana" found in the search results.'));

        final PassioFoodItem? result =
            await NutritionAI.instance.fetchFoodItemForDataInfo(foodDataInfo);
        expect(result?.name.toLowerCase(), startsWith('manzana'),
            reason: 'The food item returned should have the name "manzana".');
      });
    });
  });

  // Expected output: Verify that the "apple" with "500" "grams" serving size food item can be retrieved correctly using its associated food data info from search results.
  test(
      'Retrieve the "apple" food item with specified serving quantity and unit using food data info.',
      () async {
    await testWithSearchForFood(searchTerm: 'apple',
        (PassioSearchResponse searchResult) async {
      final PassioFoodDataInfo foodDataInfo = searchResult.results.firstWhere(
          (e) => e.foodName.toLowerCase() == 'apple',
          orElse: () => throw Exception(
              'No food item named "apple" found in the search results.'));

      final PassioFoodItem? result = await NutritionAI.instance
          .fetchFoodItemForDataInfo(foodDataInfo,
              servingQuantity: 500, servingUnit: 'gram');
      expect(result?.name, equalsIgnoringCase('apple'),
          reason: 'The food item returned should have the name "apple".');
      expect(result?.amount.selectedQuantity, 500);
      expect(result?.amount.selectedUnit, 'gram');
    });
  });

  test('Without configureSDK fetch the PassioFoodItem test', () async {
    await testWithSearchForFood(searchTerm: 'apple',
        (PassioSearchResponse searchResult) async {
      final PassioFoodDataInfo foodDataInfo = searchResult.results.firstWhere(
          (e) => e.foodName.toLowerCase() == 'apple',
          orElse: () =>
              fail('No food item named "apple" found in the search results.'));

      await testWithoutConfigureSDK(() async {
        final PassioFoodItem? result =
            await NutritionAI.instance.fetchFoodItemForDataInfo(foodDataInfo);
        expect(result, isNull);
      });
    });
  });
}
