import 'package:flutter_test/flutter_test.dart';
import 'package:nutrition_ai/nutrition_ai.dart';

import 'utils/sdk_utils.dart';

PassioTokenBudget? _tokenBudget;

void main() {
  // This function is called once before all tests are run.
  setUpAll(() async {
    await configureSDK();
  });

  runGroup();
}

void runGroup() {
  group('setAccountListener tests', () {
    runTests();
  });
}

void runTests() {
  // Expected output: Verify that _tokenBudget is updated with a non-null, valid token budget object with a non-empty API name.
  test('Set "PassioAccountListener" and call searchForFood', () async {
    const listener = MyPassioAccountListener();
    NutritionAI.instance.setAccountListener(listener);

    await NutritionAI.instance.searchForFood('Apple');

    expect(_tokenBudget, isNotNull);
    expect(_tokenBudget?.apiName, isNotEmpty);
  });

  // Expected output: Verify that the _tokenBudget should be null.
  test('Remove "PassioAccountListener" and call searchForFood', () async {
    _tokenBudget = null;
    NutritionAI.instance.setAccountListener(null);

    await NutritionAI.instance.searchForFood('Apple');

    expect(_tokenBudget, isNull);
  });

  test('set SDK language to "es" and call searchForFood', () async {
    const listener = MyPassioAccountListener();
    NutritionAI.instance.setAccountListener(listener);

    await testWithLanguage((languageResult) async {
      expect(languageResult, isTrue);

      await NutritionAI.instance.searchForFood('Apple');
    });

    expect(_tokenBudget, isNotNull);
    expect(_tokenBudget?.apiName, isNotEmpty);
  });
}

class MyPassioAccountListener implements PassioAccountListener {
  const MyPassioAccountListener();

  @override
  void onTokenBudgetUpdate(PassioTokenBudget tokenBudget) {
    _tokenBudget = tokenBudget;
  }
}
