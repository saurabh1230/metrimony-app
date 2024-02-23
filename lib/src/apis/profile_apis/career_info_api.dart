import 'dart:convert';
import 'package:bureau_couple/src/constants/shared_prefs.dart';
import 'package:bureau_couple/src/utils/urls.dart';
import 'package:http/http.dart' as http;



Future<dynamic> careerInfoAddApi({
  // required String id,
  required String company,
  required String designation,
  required String startYear,
  required String endYear,

}) async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };

  var request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseUrl}profile-setting/career/update'));
  request.fields.addAll({
    // 'id': id,
    'company': company,
    'designation': designation,
    'start': startYear,
    'end': endYear
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

Future<dynamic> careerInfoDeleteApi({
  required String id,


}) async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseUrl}profile-setting/career/delete'));
  request.fields.addAll({
    'id': id
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
