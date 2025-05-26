import 'package:flutter_test/flutter_test.dart';
import 'package:nutrition_ai/nutrition_ai.dart';
import 'package:nutrition_ai_example/domain/entity/app_secret/app_secret.dart';

void main() {
  runGroup();
}

void runGroup() {
  group('configureSDK tests', () {
    runTests();
  });
}

void runTests() {
  test('with wrong key', () async {
    const configuration = PassioConfiguration("1234567890", debugMode: 1);
    final PassioStatus status =
        await NutritionAI.instance.configureSDK(configuration);

    expect(status.mode, PassioMode.failedToConfigure);
    expect(status.missingFiles, null);
    // Android: <null>
    // iOS: 'Your key is not valid. Please contact support@passiolife.com to renew your key'
    // expect(status.debugMessage,
    //     'Your key is not valid. Please contact support@passiolife.com to renew your key');
    expect(status.error, PassioSDKError.keyNotValid);
    expect(status.activeModels, isNull);
  });

  // TODO: Need to update on iOS when the key is expired.
  // Invalid argument (name): No enum value with that name: "licensedKeyHasExpired(Optional(\"Your Key has expired on: 2021-06-21\"))"
  // Test the configuration with an expired key.
  // test('with expired key', () async {
  //   const configuration = PassioConfiguration(
  //       "8hoiPdOZCTBz3ln7hYLZCEVhfNivQWM7fdSpOFz049xN",
  //       debugMode: 1);
  //
  //   final PassioStatus status =
  //       await NutritionAI.instance.configureSDK(configuration);
  //
  //   expect(status.mode, PassioMode.failedToConfigure);
  //   expect(status.missingFiles, null);
  //   expect(status.debugMessage, 'Your Key has expired on: 2021-06-21');
  //   expect(status.error, PassioSDKError.licensedKeyHasExpired);
  //   expect(status.activeModels, isNull);
  // });

  // Expected output: The SDK should configure correctly.
  test('Provide valid proxyUrl test', () async {
    const configuration = PassioConfiguration(
      '',
      debugMode: 1,
      proxyUrl: 'https://api.passiolife.com/v2/',
    );

    final PassioStatus status =
        await NutritionAI.instance.configureSDK(configuration);

    expect(status.mode, PassioMode.isReadyForDetection);
    expect(status.missingFiles, isNull);

    // Android: <null>
    // iOS: 'The SDK is ready. Since Proxy URL is used, `remoteOnly` configuration is enabled. There\'s no need to download models.'
    // expect(status.debugMessage,
    //     'The SDK is ready. Since Proxy URL is used, `remoteOnly` configuration is enabled. There\'s no need to download models.');
    expect(status.error, isNull);
    // Android: <2>
    // iOS: null
    // expect(status.activeModels, isNull);
  });

  // Expected output: None of the API calls should work, because it's not a valid endpoint.
  test('Provide invalid proxyUrl test', () async {
    const configuration = PassioConfiguration(
      '',
      debugMode: 1,
      proxyUrl: 'http://sahilsahil.com/',
    );

    final PassioStatus status =
        await NutritionAI.instance.configureSDK(configuration);

    expect(status.mode, PassioMode.isReadyForDetection);

    final response = await NutritionAI.instance.searchForFood('apple');
    expect(response.results, isEmpty);
    expect(response.alternateNames, isEmpty);
  });

  test('with correct key', () async {
    const configuration =
        PassioConfiguration(AppSecret.passioKey, debugMode: 1);

    final PassioStatus status =
        await NutritionAI.instance.configureSDK(configuration);

    expect(status.mode, PassioMode.isReadyForDetection);
    expect(status.missingFiles, null);
    expect(status.debugMessage, null);
    expect(status.error, null);
    expect(status.activeModels, isNotNull);
  });
}
