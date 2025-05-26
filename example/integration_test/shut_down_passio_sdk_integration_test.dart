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
  group('shutDownPassioSDK tests', () {
    runTests();
  });
}

void runTests() {
  group('shutDownPassioSDK tests', () {
    test('shutDownPassioSDK test', () async {
      try {
        await NutritionAI.instance.shutDownPassioSDK();
      } catch (e) {
        fail('Failed to shut down Passio SDK: $e');
      }
    });

    // TODO: Not working on iOS.
    test('shutDownPassioSDK without configureSDK', () async {
      try {
        await testWithoutConfigureSDK(() async {
          await NutritionAI.instance.shutDownPassioSDK();
        });
      } catch (e) {
        fail('Failed to shut down Passio SDK: $e');
      }
    });

    // TODO: Not working on Android.
    test('searchForFood call after shutDownPassioSDK', () async {
      try {
        await NutritionAI.instance.shutDownPassioSDK();
        final PassioSearchResponse response =
            await NutritionAI.instance.searchForFood('Apple');
        expect(response.results, isEmpty);
        expect(response.alternateNames, isEmpty);
      } catch (e) {
        fail('Failed to search for food after shutting down Passio SDK: $e');
      }
    });
  });
}
