import 'dart:async';
import 'dart:convert';

import 'package:bureau_couple/getx/utils/app_constants.dart';
import 'package:bureau_couple/src/constants/shared_prefs.dart';
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
    return apiClient.getData(AppConstants.galleryUrl);
  }

  Future<Response> getProfileDetails() async {
    return await apiClient.getData(AppConstants.profileDataUrl);
  }

  Future<Response> getOtherUserProfile(otherUserId) async {
    return await apiClient.getData('${AppConstants.otherProfileUrl}?id=$otherUserId');
  }

  Future<Response> editEducationInfo(String? type,String? id,String? degree,fieldOfStudy,institute) async {
    return await apiClient.postData(AppConstants.editProfileDataUrl, {
      "type" :'educationInfo',
      "id" :id,
      "degree": degree,
      "field_of_study" :fieldOfStudy,
      "institute" :institute,
    });
  }
  Future<Response> editCareerInfo(String? id,String? position,String? stateOfPosting,String? districtOfPosting,String? from,String? end) async {
    return await apiClient.postData(AppConstants.editProfileDataUrl, { "type" :'careerInfo',
      "id" : id,
      "position" :position,
      "state_posting": stateOfPosting,
      "district_posting" :districtOfPosting,
      "from" : from,
      "end" : end,
    });
  }


  Future getProfileApi() async {
    var headers = {
      'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
    };
    var request = http.Request('POST', Uri.parse('$baseUrl${AppConstants.profileDataUrl}'));
    request.headers.addAll(headers);
    print(headers);
    http.StreamedResponse response = await request.send();
    var resp = jsonDecode(await response.stream.bytesToString());
    if(response.statusCode == 200 ) {
      print(resp);
      return resp;
    } else {
      print(resp);
      print(response.statusCode);
      print(response.reasonPhrase);
      return resp;
    }
  }







}
