
import 'dart:async';
import 'package:bureau_couple/getx/repository/api/api_client.dart';
import 'package:bureau_couple/getx/utils/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});



  Future<Response> login(String? username, String? password,) async {
    return await apiClient.postData(AppConstants.loginUri, {
      "username": username,
      "password": password,
    });
  }



  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }




  Future<bool> saveUserToken(String token, /*String zoneTopic*/) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    // sharedPreferences.setString(AppConstants.zoneTopic, zoneTopic);
    return await sharedPreferences.setString(AppConstants.token, token);
  }



  Future<bool> saveEmail(String email, /*String zoneTopic*/) async {
    apiClient.email = email;
    // sharedPreferences.setString(AppConstants.zoneTopic, zoneTopic);
    return await sharedPreferences.setString(AppConstants.username, email);
  }



  Future<bool> saveImage(String image, /*String zoneTopic*/) async {
    apiClient.image = image;
    // sharedPreferences.setString(AppConstants.zoneTopic, zoneTopic);
    return await sharedPreferences.setString(AppConstants.image, image);
  }
  // Future<bool> saveFirstName(String firstName, /*String zoneTopic*/) async {
  //   apiClient.firstName = firstName;
  //   // sharedPreferences.setString(AppConstants.zoneTopic, zoneTopic);
  //   return await sharedPreferences.setString(AppConstants.firstName, firstName);
  // }

  String getFirstName() {
    return sharedPreferences.getString(AppConstants.firstName) ?? "";
  }
  Future<bool> saveLastName(String lastName, /*String zoneTopic*/) async {
    apiClient.lastName = lastName;
    // sharedPreferences.setString(AppConstants.zoneTopic, zoneTopic);
    return await sharedPreferences.setString(AppConstants.lastName, lastName);
  }
  // String getLastName() {
  //   return sharedPreferences.getString(AppConstants.lastName) ?? "";
  // }
  /* Future<bool> saveImage(String image, *//*String zoneTopic*//*) async {
    apiClient.image = image;
    // sharedPreferences.setString(AppConstants.zoneTopic, zoneTopic);
    return await sharedPreferences.setString(AppConstants.image, image);
  }
*/
  String getUserImage() {
    return sharedPreferences.getString(AppConstants.image) ?? "";
  }


  String getUserEmail() {
    return sharedPreferences.getString(AppConstants.username) ?? "";
  }





  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }




  Future<void> saveUserNumberAndPassword(String username, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.password, password);
      await sharedPreferences.setString(AppConstants.username, username);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveFirstNameAndLastName(String firstName, String lastName) async {
    try {
      await sharedPreferences.setString(AppConstants.firstName, firstName);
      await sharedPreferences.setString(AppConstants.lastName, lastName);
    } catch (e) {
      rethrow;
    }
  }

  String getUserNumber() {
    return sharedPreferences.getString(AppConstants.username) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.password) ?? "";
  }

  Future<bool> clearUserNumberAndPassword() async {
    await sharedPreferences.remove(AppConstants.username);
    return await sharedPreferences.remove(AppConstants.password);
  }
  Future<Response> getAttributesUrl() {
    return apiClient.getData(AppConstants.attributesUrl);
  }


  Future<Response> getCommunityUrl(id) {
    return apiClient.getData('${AppConstants.communityListUrl}?religion_id=$id');
  }


  ///









}
