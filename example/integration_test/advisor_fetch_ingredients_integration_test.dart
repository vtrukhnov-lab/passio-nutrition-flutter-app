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
  group('Advisor - fetchIngredients tests', () {
    runTests();
  });
}

void runTests() {
  // Expected output: Verify that the fetchIngredients returns a Success result where extractedIngredients is not empty.
  test('Fetch ingredients for a valid message test', () async {
    await testWithInitConversation(() async {
      await testWithSendMessage((result) async {
        final ingredientsResult =
            await NutritionAdvisor.instance.fetchIngredients(result);
        switch (ingredientsResult) {
          case Success():
            expect(ingredientsResult.value.extractedIngredients, isNotEmpty);
            break;
          case Error():
            fail(
                'Expected Success but got Error: ${ingredientsResult.message}');
        }
      });
    });
  });

  // Expected output: Verify that fetchIngredients returns Error and the message is not empty.
  test('Fetch ingredients for an invalid response test', () async {
    const PassioAdvisorResponse response = PassioAdvisorResponse(
      markupContent: '',
      messageId: '',
      rawContent: '',
      tools: null,
      extractedIngredients: null,
      threadId: '',
    );
    final PassioResult<PassioAdvisorResponse> ingredientsResult =
        await NutritionAdvisor.instance.fetchIngredients(response);
    switch (ingredientsResult) {
      case Success():
        fail('Expected Error but got Success.');
      case Error():
        expect(ingredientsResult.message, isNotEmpty);
    }
  });

  test('Fetch ingredients without configureSDK', () async {
    await testWithInitConversation(() async {
      await testWithSendMessage((result) async {
        await testWithoutConfigureSDK(() async {
          final ingredientsResult =
              await NutritionAdvisor.instance.fetchIngredients(result);
          switch (ingredientsResult) {
            case Success():
              expect(false, isTrue);
              break;
            case Error():
              expect(ingredientsResult.message, isNotEmpty);
          }
        });
      });
    });
  });
}
