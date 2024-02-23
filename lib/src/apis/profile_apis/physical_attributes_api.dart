import 'dart:convert';
import 'package:bureau_couple/src/constants/shared_prefs.dart';
import 'package:bureau_couple/src/utils/urls.dart';
import 'package:http/http.dart' as http;

Future<dynamic> physicalAppearanceUpdateApi({
  required String height,
  required String weight,
  required String bloodGroup,
  required String eyeColor,
  required String hairColor,
  required String complexion,
  required String disability,


}) async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };

  var request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseUrl}profile-update'));
  request.fields.addAll({
    'method': 'physicalAttributes',
    'height': height,
    'weight': weight,
    'blood_group': bloodGroup,
    'eye_color': eyeColor,
    'hair_color': hairColor,
    'complexion': complexion,
    'disability': disability

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
