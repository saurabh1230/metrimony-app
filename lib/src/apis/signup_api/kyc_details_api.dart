import 'dart:convert';
import 'package:bureau_couple/src/constants/shared_prefs.dart';
import 'package:bureau_couple/src/utils/urls.dart';
import 'package:http/http.dart' as http;

Future<dynamic> kycDetailsApi({
  required String designation,
  required String identityProof,
  // required String joiningDate,
  required String photo,

}) async {
/*  var prefs = await SharedPreferences.getInstance();
  var v = prefs.getString(Keys().token);*/
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };

  var request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseUrl}kyc/store'));
  request.fields.addAll({
    'designation': designation,
    'identity_proof': identityProof,
    // 'joining_date': joiningDate
  });
  // request.files.add(await http.MultipartFile.fromPath('image', photo));
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
