import 'dart:async';
import 'dart:convert';
import 'package:bureau_couple/getx/utils/app_constants.dart';
import 'package:bureau_couple/src/constants/shared_prefs.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../api/api_client.dart';

class MatchesRepo {
  final ApiClient apiClient;

  MatchesRepo({required this.apiClient, });

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

  Future<Response> getMatchesList(page,gender,religion,state,minHeight,maxHeight,maxWeight,motherTongue,community) {
    return apiClient.getData('${AppConstants.matchesUrl}?page=$page&gender=$gender&religion=$religion&state=$state&min_height=$minHeight&max_height=$maxHeight&max_weight=$maxWeight&mother_tongue=$motherTongue&community=$community');
  }

  Future<Response> bookMarkSave(String? profileId,String? userId) async {
    Map<String, String> fields = {};
    fields.addAll(<String, String>{
      'profile_id' : profileId.toString(),
      'user_id' : userId.toString(),
      // 'status' : "2",
    });
    return apiClient.postData(
      AppConstants.bookmarkSave,fields,
    );
  }

  Future<Response> bookMarkUnSave(String? profileId,) async {
    Map<String, String> fields = {};
    fields.addAll(<String, String>{
      'profile_id' : profileId.toString(),
    }
    );
    return apiClient.postData(
      AppConstants.unSaveBookMark,fields,
    );
  }

  Future<Response> getSavedMatchesList(page,) {
    return apiClient.getData('${AppConstants.savedMatchesUrl}?page=$page');
  }


  Future<Response> sendRequest(String? userId,String? profileId) async {
    Map<String, String> fields = {};
    fields.addAll(<String, String>{
      'user_id' : userId.toString(),
      'interesting_id': profileId.toString(),
      'status': '2'
    });
    return apiClient.postData(
      AppConstants.sendRequest,fields,
    );
  }


  Future<dynamic> getMatchesApi({
    required String page,
    required String gender,
    required String religion,
    required String profession,
    required String state,
    required String height,
    required String country,
    required String montherTongue,
    required String community,
  }) async  {
    var headers = {
      'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}matches'));
    request.fields.addAll({
      'gender': gender,
      "religion" : religion,
      "profession" : profession,
      "state" : state,
      "height" : religion,
      "country" : country,
      "mother_tongue" : montherTongue,
      "community" :community });
    request.headers.addAll(headers);
    print('=================> ${request.fields}');
    http.StreamedResponse response = await request.send();
    var resp = jsonDecode(await response.stream.bytesToString());
    print(resp);
    print(headers);
    if (response.statusCode == 200) {
      return resp;
    } else {
      print(resp);
      print(response.reasonPhrase);
      print(response.statusCode);
      return resp;
    }
  }


}
