import 'dart:convert';
import 'package:bureau_couple/src/constants/shared_prefs.dart';
import 'package:bureau_couple/src/utils/urls.dart';
import 'package:http/http.dart' as http;

Future<dynamic> familyInfoUpdateApi({
  required String fatherName,
  required String fatherProfession,
  required String fatherContact,
  required String motherName,
  required String motherProfession,
  required String motherContact,
  required String totalBrother,
  required String totalSister,


}) async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };

  var request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseUrl}profile-update'));
  request.fields.addAll({
    'method': 'familyInfo',
    'father_name': fatherName,
    'father_profession': fatherProfession,
    'father_contact': fatherContact,
    'mother_name': motherName,
    'mother_profession': motherProfession,
    'mother_contact': motherContact,
    'total_brother': totalBrother,
    'total_sister': totalSister

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
