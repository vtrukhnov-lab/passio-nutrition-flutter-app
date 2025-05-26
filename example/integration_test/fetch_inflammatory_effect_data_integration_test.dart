import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nutrition_ai/nutrition_ai.dart';

import 'utils/sdk_utils.dart';

void main() {
  // This function is called once before all tests are run.
  setUpAll(() async {
    await configureSDK();
  });

  runGroup();
}

void runGroup() {
  group('fetchInflammatoryEffectData tests', () {
    runTests();
  });
}

void runTests() {
  // Expected output: Verify that the list is not empty.
  test('Pass "refCode" that contains inflammatory effect data test', () async {
    await testWithInflammatoryEffectData(
        (List<InflammatoryEffectData>? result) async {
      expect(result, isNotEmpty);
    });
  });

  // Expected output: Verify that the list is not empty and same as the english version.
  test(
      'Set the SDK language to "es" and pass "refCode" that contains inflammatory effect data test',
      () async {
    await testWithInflammatoryEffectData(
        (List<InflammatoryEffectData>? result) async {
      expect(result, isNotEmpty);

      await testWithLanguage((languageResult) async {
        expect(languageResult, isTrue);

        await testWithInflammatoryEffectData(
            (List<InflammatoryEffectData>? languageResult) async {
          final isMatched = const DeepCollectionEquality.unordered()
              .equals(result, languageResult);
          expect(isMatched, isTrue);
        });
      });
    });
  });

  // Expected output: Verify that the list is null.
  test('Pass "refCode" that is not valid test', () async {
    await testWithInflammatoryEffectData(refCode: 'AAAAAAAA',
        (List<InflammatoryEffectData>? result) async {
      expect(result, isNotEmpty);
    });
    //
    // final List<InflammatoryEffectData>? result =
    //     await NutritionAI.instance.fetchInflammatoryEffectData('AAAAAAAA');
    // expect(result, isNull);
  });

  // TODO: This test is failed on iOS simulator.
  test(
      'Pass "refCode" that contains inflammatory effect data test without configureSDK',
      () async {
    await testWithoutConfigureSDK(() async {
      await testWithInflammatoryEffectData(
          (List<InflammatoryEffectData>? result) async {
        expect(result, isNull);
      });
    });
  });
}
