

import 'package:bureau_couple/src/controller/matches_controller.dart';
import 'package:bureau_couple/src/data/repo/matches_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/api/api_client.dart';
import '../utils/app_constants.dart';



Future<void> init() async {

  /// Repository
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));



  
  Get.lazyPut(() => MatchesRepo(apiClient: Get.find(),));
  /// Controller
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => MatchesController(matchesRepo: Get.find(), apiClient: Get.find()));
}
