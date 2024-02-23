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


}) async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };

  var request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseUrl}profile-update'));
  request.fields.addAll({
    'method': 'basicInfo',
    // 'gender': 'm',
    'profession': profession,
    // 'financial_condition': 'sdadsasad',
    'religion': religion,
    'mother_tongue': motherTongue,
    'community': community,
    'smoking_status': smokingStatus,
    'drinking_status': drinkingStatus,
    // 'birth_date': '2024-02-14',
    // 'languages[]': 'english',
    'marital_status': maritalStatus,
    // 'pre_state': 'delhi',
    // 'pre_zip': '110057',
    // 'pre_city': 'new delhi',
    // 'per_country': 'india'

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

