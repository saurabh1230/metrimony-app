import 'dart:convert';
import 'package:bureau_couple/src/utils/urls.dart';
import 'package:http/http.dart' as http;

import '../../constants/shared_prefs.dart';

Future getOtherUserProfileApi({
  required String otherUserId,
}) async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('POST', Uri.parse('${baseUrl}matches-profile?id=$otherUserId'));
  request.headers.addAll(headers);
  print(headers);
  print(request);
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
