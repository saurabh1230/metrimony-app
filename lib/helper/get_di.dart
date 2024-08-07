
import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/controllers/favourite_controller.dart';
import 'package:bureau_couple/getx/controllers/filter_controller.dart';
import 'package:bureau_couple/getx/controllers/matches_controller.dart';
import 'package:bureau_couple/getx/controllers/profile_controller.dart';
import 'package:bureau_couple/getx/repository/api/api_client.dart';
import 'package:bureau_couple/getx/repository/repo/auth_repo.dart';
import 'package:bureau_couple/getx/repository/repo/matches_repo.dart';
import 'package:bureau_couple/getx/repository/repo/profile_repo.dart';
import 'package:bureau_couple/getx/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';



Future<void>   init() async {
  /// Repository


  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));

  // Repository
  
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => MatchesRepo(apiClient: Get.find(),));
  Get.lazyPut(() => ProfileRepo(apiClient: Get.find(),));

  /// Controller

  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => AuthController(authRepo:  Get.find(),sharedPreferences: Get.find()));
  Get.lazyPut(() => MatchesController(matchesRepo: Get.find(),));
  Get.lazyPut(() => FavouriteController(matchesRepo: Get.find(),));
  Get.lazyPut(() => ProfileController(profileRepo: Get.find(), ));
  Get.lazyPut(() => FavouriteController(matchesRepo: Get.find(),));
  Get.lazyPut(() => FilterController());

}
