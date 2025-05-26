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
  group('Advisor - initConversation tests', () {
    runTests();
  });
}

void runTests() {
  // Expected output: Should return Success when the SDK is properly configured.
  test(
      'Calling initConversation after configuring the SDK should return Success.',
      () async {
    await testWithInitConversation(() async {});
  });

  test('Calling initConversation without configureSDK', () async {
    await testWithoutConfigureSDK(() async {
      final PassioResult<void> result =
          await NutritionAdvisor.instance.initConversation();
      switch (result) {
        case Success():
          fail('Expected Error but got Success.');
        case Error():
          expect(result.message, isNotEmpty);
      }
    });
  });
}
