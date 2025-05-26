import 'package:collection/collection.dart';
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
  group('fetchTagsFor tests', () {
    runTests();
  });
}

void runTests() {
  // Expected output: Verify that the list is not empty.
  test('Pass "refCode" that contains tags test', () async {
    await testWithFetchTagsFor((List<String>? result) async {
      expect(result, isNotEmpty);
    });
  });

  // Expected output: Verify that the list is empty.
  test('Pass "refCode" that does not contain tags test', () async {
    await testWithFetchTagsFor(
        refCode:
            'eyJsYWJlbGlkIjoiMDAwMDAwMDAtMDAwMC0wMDAwLTAwMDAtMDAwMDAwMDAwMDAwIiwidHlwZSI6InJlZmVyZW5jZSIsInJlc3VsdGlkIjoib3BlbmZvb2QwMDE2MDAwMTg4ODUzIiwibWV0YWRhdGEiOnsic2hvcnROYW1lIjpmYWxzZX19',
        (List<String>? result) async {
      expect(result, isEmpty);
    });
  });

  // Expected output: Verify that the list is not empty and same as the english version.
  test(
      'Set the SDK language to "es" and pass "refCode" that contains tags test',
      () async {
    await testWithFetchTagsFor((List<String>? result) async {
      expect(result, isNotEmpty);

      await testWithLanguage((languageResult) async {
        expect(languageResult, isTrue);

        await testWithFetchTagsFor((List<String>? languageResult) async {
          final isMatched = const DeepCollectionEquality.unordered()
              .equals(languageResult, result);
          expect(isMatched, isTrue);
        });
      });
    });
  });

  // Expected output: Verify that the list is null.
  test('Pass "refCode" that is not valid test', () async {
    await testWithFetchTagsFor(refCode: 'AAAAAAAA',
        (List<String>? result) async {
      expect(result, isNull);
    });
  });

  test('Pass "refCode" that contains tags test without configureSDK', () async {
    await testWithoutConfigureSDK(() async {
      await testWithFetchTagsFor((List<String>? result) async {
        expect(result, isNull);
      });
    });
  });
}
