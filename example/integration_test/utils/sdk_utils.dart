import 'package:flutter_test/flutter_test.dart';
import 'package:nutrition_ai/nutrition_ai.dart';
import 'package:nutrition_ai_example/domain/entity/app_secret/app_secret.dart';

Future<void> testWithoutConfigureSDK(
    Future<void> Function() testFunction) async {
  try {
    await NutritionAI.instance.shutDownPassioSDK();
    await testFunction();
  } finally {
    await configureSDK();
  }
}

Future<void> testWithSearchForFood(
    Future<void> Function(PassioSearchResponse) testFunction,
    {String searchTerm = 'Apple'}) async {
  final PassioSearchResponse searchResult =
      await NutritionAI.instance.searchForFood(searchTerm);
  expect(searchResult, isNotNull);
  expect(searchResult.results, isNotEmpty);
  await testFunction(searchResult);
}

Future<void> testWithFetchFoodItemForRefCode(
    Future<void> Function(PassioFoodItem?) testFunction,
    {String refCode =
        'eyJsYWJlbGlkIjoiOTBmODRjMWUtOWEwZC0xMWVhLTk4YTQtYjNlZWJhZTQ4NDFkIiwidHlwZSI6InN5bm9ueW0iLCJyZXN1bHRpZCI6IjE2MDMyMTE1ODU0NDMiLCJtZXRhZGF0YSI6bnVsbH0='}) async {
  final PassioFoodItem? result =
      await NutritionAI.instance.fetchFoodItemForRefCode(refCode);
  await testFunction(result);
}

Future<void> testWithFetchFoodItemForPassioID(
    Future<void> Function(PassioFoodItem?) testFunction,
    {String passioID = 'VEG0018'}) async {
  final PassioFoodItem? result =
      await NutritionAI.instance.fetchFoodItemForPassioID(passioID);
  await testFunction(result);
}

Future<void> testWithFetchFoodItemForProductCode(
    Future<void> Function(PassioFoodItem?) testFunction,
    {String productCode = '016000188853'}) async {
  final PassioFoodItem? result =
      await NutritionAI.instance.fetchFoodItemForProductCode(productCode);
  await testFunction(result);
}

Future<void> testWithInflammatoryEffectData(
    Future<void> Function(List<InflammatoryEffectData>?) testFunction,
    {String refCode =
        'eyJsYWJlbGlkIjoiOTBmODRjMWUtOWEwZC0xMWVhLTk4YTQtYjNlZWJhZTQ4NDFkIiwidHlwZSI6InN5bm9ueW0iLCJyZXN1bHRpZCI6IjE2MDMyMTE1ODU0NDMiLCJtZXRhZGF0YSI6bnVsbH0='}) async {
  final List<InflammatoryEffectData>? result =
      await NutritionAI.instance.fetchInflammatoryEffectData(refCode);
  await testFunction(result);
}

Future<void> testWithFetchMealPlanForDay(
    Future<void> Function(List<PassioMealPlanItem>) testFunction,
    {String mealPlan = 'keto',
    int day = 1}) async {
  final List<PassioMealPlanItem> result =
      await NutritionAI.instance.fetchMealPlanForDay(mealPlan, day);
  await testFunction(result);
}

Future<void> testWithFetchMealPlans(
    Future<void> Function(List<PassioMealPlan>) testFunction) async {
  final List<PassioMealPlan> result =
      await NutritionAI.instance.fetchMealPlans();
  await testFunction(result);
}

Future<void> testWithFetchPossibleIngredients(
    Future<void> Function(PassioResult<List<PassioAdvisorFoodInfo>>)
        testFunction,
    {String foodName = 'apple'}) async {
  final PassioResult<List<PassioAdvisorFoodInfo>> result =
      await NutritionAI.instance.fetchPossibleIngredients(foodName);
  await testFunction(result);
}

Future<void> testWithFetchSuggestions(
    Future<void> Function(List<PassioFoodDataInfo>) testFunction,
    {PassioMealTime mealTime = PassioMealTime.breakfast}) async {
  final List<PassioFoodDataInfo> result =
      await NutritionAI.instance.fetchSuggestions(mealTime);
  await testFunction(result);
}

Future<void> testWithFetchTagsFor(
    Future<void> Function(List<String>?) testFunction,
    {String refCode =
        'eyJsYWJlbGlkIjoiOTBmODRjMWUtOWEwZC0xMWVhLTk4YTQtYjNlZWJhZTQ4NDFkIiwidHlwZSI6InN5bm9ueW0iLCJyZXN1bHRpZCI6IjE2MDMyMTE1ODU0NDMiLCJtZXRhZGF0YSI6bnVsbH0='}) async {
  final List<String>? result = await NutritionAI.instance.fetchTagsFor(refCode);
  await testFunction(result);
}

Future<void> testWithFetchUltraProcessingFoodRating(
    Future<void> Function(PassioResult<PassioUPFRating>) testFunction,
    {required PassioFoodItem foodItem}) async {
  final PassioResult<PassioUPFRating> result =
      await NutritionAI.instance.fetchUltraProcessingFoodRating(foodItem);
  await testFunction(result);
}

Future<void> testWithFetchVisualAlternatives(
    Future<void> Function(PassioResult<List<PassioAdvisorFoodInfo>>)
        testFunction,
    {String foodName = 'apple'}) async {
  final PassioResult<List<PassioAdvisorFoodInfo>> result =
      await NutritionAI.instance.fetchVisualAlternatives(foodName);
  await testFunction(result);
}

Future<void> testWithPredictNextIngredients(
    Future<void> Function(List<PassioFoodDataInfo>) testFunction,
    {List<String> ingredients = const ['cheese', 'tomato']}) async {
  final List<PassioFoodDataInfo> result =
      await NutritionAI.instance.predictNextIngredients(ingredients);
  await testFunction(result);
}

Future<void> testWithLanguage(Future<void> Function(bool) testFunction,
    {String languageCode = 'es'}) async {
  try {
    final bool result = await updateLanguage(languageCode);
    await testFunction(result);
  } finally {
    final bool result = await updateLanguage('en');
    expect(result, isTrue);
  }
}

Future<void> testWithInitConversation(
    Future<void> Function() testFunction) async {
  final PassioResult<void> result =
      await NutritionAdvisor.instance.initConversation();
  switch (result) {
    case Error():
      fail('initConversation failed: ${result.message}');
    case Success():
  }
  await testFunction();
}

Future<void> testWithSendMessage(
    Future<void> Function(PassioAdvisorResponse) testFunction,
    {String message = 'Coffee with milk'}) async {
  final PassioResult<PassioAdvisorResponse> messageResult =
      await NutritionAdvisor.instance.sendMessage(message);
  switch (messageResult) {
    case Error():
      fail('sendMessage failed: ${messageResult.message}');
    case Success():
  }
  await testFunction(messageResult.value);
}

Future<void> configureSDK() async {
  const configuration = PassioConfiguration(AppSecret.passioKey);
  final status = await NutritionAI.instance.configureSDK(configuration);
  expect(status.mode, PassioMode.isReadyForDetection);
}

Future<bool> updateLanguage(String languageCode) async {
  return await NutritionAI.instance.updateLanguage(languageCode);
}
