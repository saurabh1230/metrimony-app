import 'dart:convert';
import 'package:bureau_couple/src/constants/shared_prefs.dart';
import 'package:bureau_couple/src/utils/urls.dart';
import 'package:http/http.dart' as http;

Future<dynamic> forgotPassEmailApi({
  required String email,
}) async {
  var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}password/email'));
  request.fields.addAll({
    'value': email,
  });
  print(request.fields);
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

Future<dynamic> forgotPassOtpApi({
  required String email,
  required String code,
}) async {
  var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}password/verify-code'));
  request.fields.addAll({
    'email': email,
    'code': code
  });
  print(request.fields);
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

Future<dynamic> forgotEnterNewPassApi({
  required String email,
  required String password,
  required String confirmPassword,
  required String code,
}) async {
  var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}password/reset'));
  request.fields.addAll({
    'email': email,
    'password': password,
    'password_confirmation': confirmPassword,
    'token': code
  });
  print(request.fields);
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


Future<dynamic> changePasswordApi({
  required String currentPassword,
  required String oldPassword,
  required String confirmPassword,
}) async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}change-password'));
  request.fields.addAll({
    'current_password': currentPassword,
    'password': oldPassword,
    'password_confirmation': confirmPassword
  });
  request.headers.addAll(headers);
  print(request.fields);
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
