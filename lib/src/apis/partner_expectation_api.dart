import 'dart:convert';
import 'package:bureau_couple/src/constants/shared_prefs.dart';
import 'package:bureau_couple/src/utils/urls.dart';
import 'package:http/http.dart' as http;

Future<dynamic> partnerExpectationUpdateApi({
  required String generalRequirement,
  required String country,
  required String minAge,
  required String maxAge,
  required String minHeight,
  required String maxHeight,
  required String maxWeight,
  required String religion,
  required String community,
  required String smokingStatus,
  required String drinkingStatus,
  required String profession,
  required String minDegree,
  required String financialCondition,
  required String language,
  required String motherTongue,


}) async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };

  var request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseUrl}profile-update'));
  request.fields.addAll({
    'method': 'partnerExpectation',
    "general_requirement" : generalRequirement,
    'mother_tongue' : motherTongue,
    'country': country,
    'min_age': minAge,
    'max_age': maxAge,
    'min_height': "5.5",
    "max_height" :"6.2",
    'max_weight': maxWeight,
    'religion': religion,
    'community': community,
    'smoking_status': smokingStatus,
   'drinking_status': drinkingStatus,
   "profession":profession,
   "min_degree":minDegree,
   // "financial_condition":financialCondition,
    // "language[]": language


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
