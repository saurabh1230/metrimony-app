
import 'dart:convert';
import 'package:bureau_couple/src/constants/shared_prefs.dart';
import 'package:bureau_couple/src/utils/urls.dart';
import 'package:http/http.dart' as http;

Future<dynamic> getMatchesApi({
  required String page,
  required String gender,
}) async  {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}matches?page=$page'));
  request.fields.addAll({
    'gender': gender,
  });

  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  print(resp);
  print(headers);
  if (response.statusCode == 200) {
    return resp;
  } else {
    print(resp);
    print(response.reasonPhrase);
    print(response.statusCode);
    return resp;
  }
}

Future<dynamic> getNewMatchesApi({
  required String page,
  required String gender,
}) async  {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}matches'));
  request.fields.addAll({
    'gender': gender
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  print(resp);
  print(headers);
  if (response.statusCode == 200) {
    return resp;
  } else {
    print(resp);
    print(response.reasonPhrase);
    print(response.statusCode);
    return resp;
  }
}


Future<dynamic> getMatchesByGenderApi({
  required String gender,
  required String page,
  required String religion,
  required String height,
  required String state,
}) async  {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}matches?page=$page'));
  request.fields.addAll({
    'gender': gender,
    'religion': religion,
    'height' : height,
    "state" : state,
  });
  print(request.fields);

  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  print(resp);
  print(headers);
  if (response.statusCode == 200) {
    return resp;
  } else {
    print(resp);
    print(response.reasonPhrase);
    print(response.statusCode);
    return resp;
  }
}

Future<dynamic> getMatchesFilterApi({
  required String religion,
  required String maritalStatus,
  required String page,
  required String gender,
  required String country,
  required String height,
  required String motherTongue,
}) async  {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}matches?page=$page'));
  request.fields.addAll({
    'gender': gender,
    'religion': religion,
    'marital_status' : maritalStatus,
    'country' : country,
    'height' : height,
    'mother_tongue' : motherTongue,
  });
  print(request.fields);

  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  print(resp);
  print(headers);
  if (response.statusCode == 200) {
    return resp;
  } else {
    print(resp);
    print(response.reasonPhrase);
    print(response.statusCode);
    return resp;
  }
}



Future<dynamic> getConnectedMatchesApi({
  required String page,
}) async  {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}interest/all?page=$page'));
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  print(resp);
  print(headers);
  if (response.statusCode == 200) {
    return resp;
  } else {
    print(resp);
    print(response.reasonPhrase);
    print(response.statusCode);
    return resp;
  }
}

Future<dynamic> getReligionMatchesFilterApi({
  required String religion,
  required String page,
  required String gender,
}) async  {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}matches?page=$page'));
  request.fields.addAll({
    'gender': gender,
    'religion': religion,
  });
  print(request.fields);

  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  print(resp);
  print(headers);
  if (response.statusCode == 200) {
    return resp;
  } else {
    print(resp);
    print(response.reasonPhrase);
    print(response.statusCode);
    return resp;
  }
}