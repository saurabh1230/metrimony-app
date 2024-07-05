import 'dart:async';

import 'package:bureau_couple/getx/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../api/api_client.dart';

class ProfileRepo {
  final ApiClient apiClient;

  ProfileRepo({required this.apiClient, });

/*  Future<Response> updateProfile(String? firstName, String? lastName, String? mobile) async {
    return await apiClient.postData(AppConstants.profileUpdate, {"firstname": firstName, "lastname": lastName,"mobile" :mobile});
  }*/

  //
  // Future<Response> bookMarkSave(String? profileId,) async {
  //   Map<String, String> fields = {};
  //   fields.addAll(<String, String>{
  //     'profile_id' : profileId.toString()
  //   });
  //   return apiClient.postData(
  //     AppConstants.bookmarkSave,fields,
  //   );
  // }
  //
  // Future<Response> bookMarkUnSave(String? profileId,) async {
  //   Map<String, String> fields = {};
  //   fields.addAll(<String, String>{
  //     'profile_id' : profileId.toString()
  //   });
  //   return apiClient.postData(
  //     AppConstants.unSaveBookMark,fields,
  //   );
  // }

  Future<Response> getGalleryImages() {
    return apiClient.getData('${AppConstants.galleryUrl}');
  }

  Future<Response> getProfileDetails() async {
    return await apiClient.getData('${AppConstants.profileDataUrl}');
  }

  Future<Response> getOtherUserProfile(otherUserId) async {
    return await apiClient.getData('${AppConstants.otherProfileUrl}?id=$otherUserId');
  }





}
