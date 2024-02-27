import 'dart:convert';
import 'package:bureau_couple/src/constants/shared_prefs.dart';
import 'package:bureau_couple/src/utils/urls.dart';
import 'package:http/http.dart' as http;

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
    'profession': profession,
    'financial_condition': financialCondition,
    'religion': religion,
    'mother_tongue': motherTongue,
    'community': community,
    'smoking_status': smokingStatus,
    'drinking_status': drinkingStatus,
    'birth_date': birthDate,
    'languages[]': "English,Hindi",
    'marital_status': maritalStatus,
    'pre_state': state,
    'pre_zip': zip,
    'pre_city': city,
    'per_country': country,
    'lastname': firstName,
    'firstname': lastName

  });
  request.headers.addAll(headers);
  print(request.fields);
  print(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  print(resp);
  if (response.statusCode == 200) {
    return resp;
  } else {
    print(resp);
    print(response.reasonPhrase);
    print(response.statusCode);
    return resp;
  }
}

