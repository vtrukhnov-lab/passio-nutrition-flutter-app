import 'package:flutter_test/flutter_test.dart';
import 'package:nutrition_ai/nutrition_ai.dart';
import 'package:nutrition_ai_example/domain/entity/app_secret/app_secret.dart';

import 'utils/sdk_utils.dart';

void main() {
  // This function is called once before all tests are run.
  setUpAll(() async {
    // Configure the Passio SDK with a key for testing.
    const configuration = PassioConfiguration(AppSecret.passioKey);
    final status = await NutritionAI.instance.configureSDK(configuration);
    expect(status.mode, PassioMode.isReadyForDetection);
  });

  runGroup();
}

void runGroup() {
  group('predictNextIngredients tests', () {
    runTests();
  });
}

void runTests() {
  // Expected output: Verify that the result should not empty.
  test('Pass "[cheese, tomato] to predictNextIngredients', () async {
    await testWithPredictNextIngredients((result) async {
      expect(result, isNotEmpty);
    });
  });

  // Expected output: Verify that the result should be success and the value should be true.
  test(
      'Set the SDK language to "es" and pass "[cheese, tomato] to predictNextIngredients',
      () async {
    await testWithLanguage((languageResult) async {
      expect(languageResult, isTrue);

      await testWithPredictNextIngredients((result) async {
        expect(result, isNotEmpty);
      });
    });
  });

  // Expected output: Verify that the result should be empty.
  test('Pass empty list', () async {
    await testWithPredictNextIngredients(ingredients: [], (result) async {
      expect(result, isEmpty);
    });
  });

  test('Pass "[cheese, tomato] to predictNextIngredients without configureSDK',
      () {
    testWithoutConfigureSDK(() async {
      await testWithPredictNextIngredients((result) async {
        expect(result, isEmpty);
      });
    });
  });
}
