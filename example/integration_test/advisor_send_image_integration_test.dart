import 'package:flutter/services.dart';
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
  group('Advisor - sendImage tests', () {
    runTests();
  });
}

void runTests() {
  // Expected output: Verify that the result is Success, extractedIngredients is not empty, and markupContent, messageId, rawContent, and tools are empty.
  test('Pass valid food image test', () async {
    await testWithInitConversation(() async {
      final ByteData data =
          await rootBundle.load('assets/images/img_multiple_foods.jpg');
      final Uint8List bytes = data.buffer.asUint8List();
      final PassioResult<PassioAdvisorResponse> result =
          await NutritionAdvisor.instance.sendImage(bytes);
      switch (result) {
        case Success():
          expect(result.value.extractedIngredients, isNotEmpty);
          expect(result.value.markupContent, isEmpty);
          expect(result.value.messageId, isEmpty);
          expect(result.value.rawContent, isEmpty);
          expect(result.value.tools, null);
          break;
        case Error():
          fail('Expected Success but got Error: ${result.message}');
      }
    });
  });

  // Expected output: Verify that the result is Error, and the message is not empty.
  test('Pass Image not containing any food or food packaging test', () async {
    await testWithInitConversation(() async {
      final ByteData data =
          await rootBundle.load('assets/images/img_passio.jpg');
      final Uint8List bytes = data.buffer.asUint8List();
      final PassioResult<PassioAdvisorResponse> result =
          await NutritionAdvisor.instance.sendImage(bytes);
      switch (result) {
        case Success():
          fail('Expected Error but got Success.');
        case Error():
          expect(result.message, isNotEmpty);
      }
    });
  });

  test('Pass valid food image without configureSDK test', () async {
    await testWithInitConversation(() async {
      await testWithoutConfigureSDK(() async {
        final ByteData data =
            await rootBundle.load('assets/images/img_multiple_foods.jpg');
        final Uint8List bytes = data.buffer.asUint8List();
        final PassioResult<PassioAdvisorResponse> result =
            await NutritionAdvisor.instance.sendImage(bytes);
        switch (result) {
          case Success():
            fail('Expected Error but got Success.');
          case Error():
            expect(result.message, isNotEmpty);
        }
      });
    });
  });
}
