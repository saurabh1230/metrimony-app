import 'dart:convert';
import 'package:bureau_couple/src/constants/shared_prefs.dart';
import 'package:bureau_couple/src/utils/urls.dart';
import 'package:http/http.dart' as http;

Future<dynamic> educationInfoAddApi({
  required String institute,
  required String degree,
  required String fieldOfStudy,
  required String regNO,
  required String start,
  required String end,
  required String result,
  required String outOf,
  required String rollNo,

}) async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };

  var request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseUrl}profile-setting/education/update'));
  request.fields.addAll({
    'institute': institute,
    'degree': degree,
    'field_of_study': fieldOfStudy,
    'reg_no': regNO,
    'start': start,
    'end': end,
    'result': result,
    'out_of': outOf,
    'roll_no': rollNo,

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

Future<dynamic> educationInfoDeleteApi({
  required String id,


}) async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseUrl}profile-setting/education/delete'));
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
