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
  group('iconURLFor tests', () {
    runTests();
  });
}

void runTests() {
  group('iconURLFor tests', () {
    // Expected output: The returned image url should not be empty.
    test('Pass the "VEG0018" as passioID test', () async {
      final String result = await NutritionAI.instance.iconURLFor('VEG0018');
      expect(result, isNotEmpty);
    });

    // Expected output: The returned image url should not be empty, and it should contains 360 in url.
    test('Pass the "VEG0018" as passioID with iconSize of 360px test',
        () async {
      final String result = await NutritionAI.instance
          .iconURLFor('VEG0018', iconSize: IconSize.px360);
      expect(result, isNotEmpty);
      expect(result, contains('360'));
    });

    test('Pass the "VEG0018" as passioID without configureSDK test', () async {
      await testWithoutConfigureSDK(() async {
        final String result = await NutritionAI.instance.iconURLFor('VEG0018');
        expect(result, isEmpty);
      });
    });
  });
}
