import 'dart:convert';
import 'package:bureau_couple/src/constants/shared_prefs.dart';
import 'package:bureau_couple/src/utils/urls.dart';
import 'package:http/http.dart' as http;



Future<dynamic> sendRequestApi({
  required String memberId,


}) async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };

  var request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseUrl}express-interest'));
  request.fields.addAll({
    // 'id': id,
    'interesting_id': memberId
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

Future<dynamic> getRequestApi() async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseUrl}interest/request'));
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

Future<dynamic> acceptRequestApi({
  required String id,


}) async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };

  var request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseUrl}interest/accept-interest'));
  request.fields.addAll({
    // 'id': id,
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

Future<dynamic> rejectRequestApi({
  required String id,


}) async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };

  var request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseUrl}ignore'));
  request.fields.addAll({
    // 'id': id,
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