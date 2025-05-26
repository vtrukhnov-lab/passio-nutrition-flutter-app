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
  group('Advisor - sendMessage tests', () {
    runTests();
  });
}

void runTests() {
  setUpAll(() async {
    // Initialize the conversation before running the tests.
    final PassioResult<void> result =
        await NutritionAdvisor.instance.initConversation();
    switch (result) {
      case Error():
        fail(
            'initConversation failed, cannot test advisorSendMessage: ${result.message}');
      case Success():
    }
  });

  // Expected output: Verify that the result is Success, markupContent, messageId, rawContent, and tools are not empty, and extractedIngredients is null.
  test('Pass valid message "Coffee with milk" test', () async {
    final PassioResult<PassioAdvisorResponse> result =
        await NutritionAdvisor.instance.sendMessage('Coffee with milk');
    switch (result) {
      case Success():
        expect(result.value.extractedIngredients, isNull);
        expect(result.value.markupContent, isNotEmpty);
        expect(result.value.messageId, isNotEmpty);
        expect(result.value.rawContent, isNotEmpty);
        expect(result.value.tools, isNotEmpty);
        break;
      case Error():
        fail('Expected Success but got Error: ${result.message}');
    }
  });

  // Expected output: Verify that the result is Error, and the message is not empty.
  test('Pass empty message test', () async {
    final PassioResult<PassioAdvisorResponse> result =
        await NutritionAdvisor.instance.sendMessage('');
    switch (result) {
      case Success():
        fail('Expected Error but got Success.');
      case Error():
        expect(result.message, isNotEmpty);
    }
  });

  test('Pass message with only spaces test', () async {
    final PassioResult<PassioAdvisorResponse> result =
        await NutritionAdvisor.instance.sendMessage('   ');
    switch (result) {
      case Success():
        expect(result.value.rawContent, isNotEmpty);
        expect(result.value.markupContent, isNotEmpty);
        break;
      case Error():
        fail('Expected Success but got Error: ${result.message}');
    }
  });

  test('Pass valid message without configureSDK test', () async {
    await testWithoutConfigureSDK(() async {
      final PassioResult<PassioAdvisorResponse> result =
          await NutritionAdvisor.instance.sendMessage('Coffee with milk');
      switch (result) {
        case Error():
          expect(result.message, isNotEmpty);
          break;
        case Success():
          fail('Expected Error but got Success.');
      }
    });
  });
}
