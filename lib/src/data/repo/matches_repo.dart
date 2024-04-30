import 'dart:async';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class MatchesRepo {
  final ApiClient apiClient;

  MatchesRepo({required this.apiClient, });

/*  Future<Response> updateProfile(String? firstName, String? lastName, String? mobile) async {
    return await apiClient.postData(AppConstants.profileUpdate, {"firstname": firstName, "lastname": lastName,"mobile" :mobile});
  }*/


  Future<Response> bookMarkSave(String? profileId,) async {
    Map<String, String> fields = {};
    fields.addAll(<String, String>{
      'profile_id' : profileId.toString()
    });
    return apiClient.postData(
      AppConstants.bookmarkSave,fields,
    );
  }

  Future<Response> bookMarkUnSave(String? profileId,) async {
    Map<String, String> fields = {};
    fields.addAll(<String, String>{
      'profile_id' : profileId.toString()
    });
    return apiClient.postData(
      AppConstants.unSaveBookMark,fields,
    );
  }

  Future<Response> getMatchesList(page) {
    return apiClient.getData('${AppConstants.matchesUrl}?page$page');
  }



}
