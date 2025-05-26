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
  group('searchForFood tests', () {
    runTests();
  });
}

void runTests() {
  // Expected output: Empty list/array
  test('Empty string', () async {
    final result = await NutritionAI.instance.searchForFood('');
    expect(result.alternateNames, isEmpty);
    expect(result.results, isEmpty);
  });

  /// TODO: Uncomment once fix is available
  // Expected output: Empty list/array
  test('String with less than 3 characters', () async {
    final result = await NutritionAI.instance.searchForFood('Ap');
    expect(result.alternateNames, isEmpty);
    expect(result.results, isEmpty);
  });

  // Expected output: At least one item containing the foodName "apple", at least one suggestion containing the word "apple"
  test('Apple', () async {
    final result = await NutritionAI.instance.searchForFood('Apple');
    expect(
        result.results,
        anyElement((PassioFoodDataInfo e) =>
            e.foodName.toLowerCase().contains('apple')));
    expect(result.alternateNames,
        anyElement((String e) => e.toLowerCase().contains('apple')));
  });

  // Expected output: At least one item containing the foodName "salad", , at least one suggestion containing the word "salad"
  test('Homemade Shrimp Cobb salad', () async {
    final PassioSearchResponse result =
        await NutritionAI.instance.searchForFood('Homemade Shrimp Cobb salad');
    expect(
        result.results,
        anyElement((PassioFoodDataInfo e) =>
            e.foodName.toLowerCase().contains('salad')));
    expect(result.alternateNames,
        anyElement((String e) => e.toLowerCase().contains('salad')));
  });

  // Expected output: At least one item containing the foodName "blueberries", at least one suggestion containing the word "blueberries"
  // test('blueberries', () async {
  //   final result = await NutritionAI.instance.searchForFood('arándanos ');
  //   expect(result.results, anyElement((PassioFoodDataInfo e) => e.foodName.toLowerCase().contains('blueberries')));
  //   expect(result.alternateNames, anyElement((String e) => e.toLowerCase().contains('blueberries')));
  // });

  // Expected output: At least one item containing the foodName "pera", at least one suggestion containing the word "pera"
  test('Set SDK language to "es", search for "pera"', () async {
    final languageResult = await NutritionAI.instance.updateLanguage('es');
    expect(languageResult, isTrue);
    final result = await NutritionAI.instance.searchForFood('pera');
    expect(
        result.results,
        anyElement((PassioFoodDataInfo e) =>
            e.foodName.toLowerCase().contains('pera')));
    expect(result.alternateNames,
        anyElement((String e) => e.toLowerCase().contains('pera')));
  });

  test('Search for "Apple" without configuring the SDK', () async {
    await testWithoutConfigureSDK(() async {
      final result = await NutritionAI.instance.searchForFood('Apple');
      expect(result.results, isEmpty);
      expect(result.alternateNames, isEmpty);
    });
  });
}
