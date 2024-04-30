
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../data/api/api_client.dart';
import '../data/repo/matches_repo.dart';

import '../models/matches_model.dart';
import '../utils/app_constants.dart';

class MatchesController extends GetxController implements GetxService {
  final MatchesRepo matchesRepo;
  final ApiClient apiClient;
  MatchesController({required this.matchesRepo, required this.apiClient, }) ;




  bool _isLoading = false;



  XFile? _pickedImage;
  XFile? _pickedCover;
  int? _categoryIndex = 0;

  bool get isLoading => _isLoading;

  XFile? get pickedImage => _pickedImage;
  XFile? get pickedCover => _pickedCover;
  int? get categoryIndex => _categoryIndex;



  List<MatchesModel>? _matchesList;
  List<MatchesModel>? get matchesList => _matchesList;

  int? _matchesIndex = 0;
  int? get matches => _matchesIndex;

  List<int?> _matchesId = [];
  List<int?> get mlaIds => _matchesId;
  Future<void> getMatchesList(String page) async {
    _isLoading = true;
    try {
      Response response = await matchesRepo.getMatchesList(page);
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.body['data']['members']['data'];
        _matchesList ??= [];
        _matchesList!.addAll(responseData.map((json) => MatchesModel.fromJson(json)).toList());
        // Check if there are more pages
        if (responseData.length == 0) {
          // No more matches available
          // _hasMoreMatches = false;
        }
      } else {
        // Handle API error
      }
    } catch (error) {
      // Handle network error
    } finally {
      _isLoading = false;
      update();
    }
  }
  // Future<void> getMatchesList(page) async {
  //   _isLoading = true;
  //   update();
  //   try {
  //     Response response = await matchesRepo.getMatchesList(page);
  //     if (response.statusCode == 200) {
  //       List<dynamic> responseData = response.body['data']['members']['data'];
  //       _matchesList = responseData.map((json) => MatchesModel.fromJson(json)).toList();
  //       _matchesId = [0, ..._matchesList!.map((e) => e.id)];
  //     } else {
  //       // ApiChecker.checkApi(response);
  //     }
  //   } catch (error) {
  //     // Handle errors, such as network failures, here.
  //     print("Error while fetching MLA list: $error");
  //     // You might want to set _mlaList and _mlaIds to null or empty lists here.
  //   }
  //   _isLoading = false;
  //   update();
  // }


/*
  Future<ResponseModel?> updateProfile(String? firstName, String lastName, String mobile) async {
    _isLoading = true;
    update();
    Response response = await profileRepo.updateProfile(firstName, lastName,mobile);
    ResponseModel? responseModel;
    print('=====www====>response.bodyString ${response.bodyString}');
    print('=====www====>response.statusText ${response.statusText}');
    print('=====www====>response.body ${response.body}');
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = response.body;
      if (responseBody['message'] != null && responseBody['message']['success'] != null) {
        List<dynamic> successMessage = responseBody['message']['success'];
        if (successMessage.length == 2 && successMessage[0] == "success") {
          responseModel = ResponseModel(true, successMessage[1]);
        } else {
          // Handle unexpected response format
          responseModel = ResponseModel(false, "Unexpected response format");
        }
      } else {
        responseModel = ResponseModel(false, "No success message found in response");
      }

    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

*/









/*
  Future<void> updateProfileApi(*/
/*AddComplaint addComplaint*//*
String? firstName,String? lastName,String? mobile, XFile? image,*/
/*String? name,String? email,String? subject,String? priority,String? message,String? vidhanId, XFile? image,*//*
) async {
    _isLoading = true;
    update();

    Response response = await profileRepo.updateProfile( firstName,lastName,mobile,image,
    );
    if(response.statusCode == 200) {
      // Get.offAllNamed(RouteHelper.getInitialRoute());
      showCustomSnackBar('Profile Update Successfully', isError: false);
    }else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }
*/


  Future<void> bookMarkSaveApi(String? profileId,) async {
    _isLoading = true;
    update();

    Response response = await matchesRepo.bookMarkSave(profileId);
    if(response.statusCode == 200) {
      // Get.offAllNamed(RouteHelper.getSignInRoute());
      // showCustomSnackBar('Password Changed Successful', isError: false);
    }else {
      // ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  Future<void> unSaveBookmarkApi(String? profileId,) async {
    _isLoading = true;
    update();

    Response response = await matchesRepo.bookMarkUnSave(profileId);
    if(response.statusCode == 200) {
      // Get.offAllNamed(RouteHelper.getSignInRoute());
      // showCustomSnackBar('Password Changed Successful', isError: false);
    }else {
      // ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }








  void showBottomLoader() {
    _isLoading = true;
    update();
  }






  void pickImage(bool isLogo, bool isRemove) async {
    if(isRemove) {
      _pickedImage = null;
      _pickedCover = null;
    }else {
      if (isLogo) {
        _pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      } else {
        _pickedCover = await ImagePicker().pickImage(source: ImageSource.gallery);
      }
      update();
    }
  }

  void setCategoryIndex(int? index, bool notify) {
    _categoryIndex = index;
    if(notify) {
      update();
    }
  }


}
