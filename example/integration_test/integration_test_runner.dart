import 'package:flutter_test/flutter_test.dart';
import 'package:nutrition_ai/nutrition_ai.dart';

import 'advisor_fetch_ingredients_integration_test.dart'
    as advisor_fetch_ingredients;
import 'advisor_init_conversation_integration_test.dart'
    as advisor_init_conversation;
import 'advisor_send_image_integration_test.dart' as advisor_send_image;
import 'advisor_send_message_integration_test.dart' as advisor_send_message;
import 'configure_sdk_integration_test.dart' as configure_sdk;
import 'fetch_food_item_for_data_info_integration_test.dart'
    as fetch_food_item_for_data_info;
import 'fetch_food_item_for_passio_id_integration_test.dart'
    as fetch_food_item_for_passio_id;
import 'utils/sdk_utils.dart';

void main() {
  setUpAll(() async {
    await configureSDK();
  });

  // advisor_fetch_ingredients.runGroup();
  // advisor_init_conversation.runGroup();
  // advisor_send_image.runGroup();
  // advisor_send_message.runGroup();
  // configure_sdk.runGroup();
  // fetch_food_item_for_data_info.runGroup();
  fetch_food_item_for_passio_id.runGroup();
  // fetch_food_item_for_product_code.runGroup();
  // fetch_food_item_for_ref_code.runGroup();
  // fetch_food_item_legacy.runGroup();
  // fetch_hidden_ingredients.runGroup();
  // fetch_icon_for.runGroup();
  // fetch_inflammatory_effect_data.runGroup();
  // fetch_meal_plan_for_day.runGroup();
  // fetch_meal_plans.runGroup();
  // fetch_possible_ingredients.runGroup();
  // fetch_suggestions.runGroup();
  // fetch_tags_for.runGroup();
  // fetch_ultra_processing_food_rating.runGroup();
  // fetch_visual_alternatives.runGroup();
  // get_sdk_version.runGroup();
  // icon_url_for.runGroup();
  // lookup_icons_for.runGroup();
  // predict_next_ingredients.runGroup();
  // recognize_image_remote.runGroup();
  // recognize_nutrition_facts_remote.runGroup();
  // recognize_speech_remote.runGroup();
  // report_food_item.runGroup();
  // search_for_food.runGroup();
  // search_for_food_semantic.runGroup();
  // set_account_listener.runGroup();
  // set_passio_status_listener.runGroup();
  // shut_down_passio_sdk.runGroup();
  // submit_user_created_food.runGroup();
  // transform_cg_rect_form.runGroup();
  // update_language.runGroup();

  tearDownAll(() async {
    await NutritionAI.instance.shutDownPassioSDK();
  });
}
