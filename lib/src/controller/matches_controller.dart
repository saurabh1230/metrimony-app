
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../data/api/api_client.dart';
import '../data/repo/matches_repo.dart';

import '../utils/app_constants.dart';

class MatchesController extends GetxController implements GetxService {
  final MatchesRepo profileRepo;
  final ApiClient apiClient;
  MatchesController({required this.profileRepo, required this.apiClient, }) ;




  bool _isLoading = false;



  XFile? _pickedImage;
  XFile? _pickedCover;
  int? _categoryIndex = 0;

  bool get isLoading => _isLoading;

  XFile? get pickedImage => _pickedImage;
  XFile? get pickedCover => _pickedCover;
  int? get categoryIndex => _categoryIndex;


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

    Response response = await profileRepo.bookMarkSave(profileId);
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

    Response response = await profileRepo.bookMarkUnSave(profileId);
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
