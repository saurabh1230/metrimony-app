import 'dart:convert';
import 'package:bureau_couple/getx/controllers/auth_controller.dart';
import 'package:bureau_couple/getx/controllers/profile_controller.dart';
import 'package:bureau_couple/src/constants/shared_prefs.dart';
import 'package:bureau_couple/src/utils/urls.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

Future<dynamic> updateBasicInfo({
  required String profession,
  required String religion,
  required String motherTongue,
  required String community,
  required String smokingStatus,
  required String drinkingStatus,
  required String maritalStatus,
  required String birthDate,
  // required List<String> language,
  required String state,
  required String zip,
  required String city,
  required String country,
  required String gender,
  required String financialCondition,
  required String firstName,
  required String lastName,
  required String aboutUs,


}) async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };

  var request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseUrl}profile-update'));
  request.fields.addAll({
    'method': 'basicInfo',
    'gender': gender,
    'profession': Get.find<ProfileController>().userDetails!.data!.user!.profession!.id.toString(),
    'financial_condition': financialCondition,
    'religion': Get.find<ProfileController>().userDetails!.data!.user!.religion!.id.toString(),
    'mother_tongue': Get.find<ProfileController>().userDetails!.data!.user!.motherTongue!.id.toString(),
    'community': Get.find<ProfileController>().userDetails!.data!.user!.community!.id.toString(),
    'smoking_status': smokingStatus,
    'drinking_status': drinkingStatus,
    'birth_date': birthDate,
    'languages[]': "English,Hindi",
    'marital_status': maritalStatus,
    'pre_state': state,
    'pre_zip': zip,
    'pre_city': city,
    'per_country': country,
    'lastname': lastName,
    'firstname': firstName,
    "about_us" : aboutUs,
    // "height" : "5.45",
    "user_type" : "1"

  });
  print(request.fields);
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(resp);
    return resp;
  } else {
    print(resp);
    print(response.reasonPhrase);
    print(response.statusCode);
    return resp;
  }
}

