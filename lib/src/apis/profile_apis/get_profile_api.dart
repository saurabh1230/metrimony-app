import 'dart:convert';

import 'package:bureau_couple/src/utils/urls.dart';
import 'package:http/http.dart' as http;

import '../../constants/shared_prefs.dart';

Future getProfileApi() async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('POST', Uri.parse('${baseUrl}profileData'));
  request.headers.addAll(headers);
  print(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if(response.statusCode == 200 ) {
    print(resp);
    return resp;
  } else {
    print(resp);
    print(response.statusCode);
    print(response.reasonPhrase);
    return resp;
  }
}


Future<dynamic> addProfileImageAPi({
  required String photo,
}) async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };

  var request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseUrl}profile/picture/update'));
    request.files
        .add(await http.MultipartFile.fromPath('image', photo));


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

