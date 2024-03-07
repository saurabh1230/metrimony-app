import 'dart:convert';

import 'package:bureau_couple/src/utils/urls.dart';
import 'package:http/http.dart' as http;


Future<dynamic> signUpApi({
  required String userName,
  required String email,
  required String password,
  required String mobileNo,
  required String passwordConfirmation,
  required String country,
  required String firstName,
  required String lastName,
  required String lookingFor,
  required String gender,
  required String motherTongue,
  required String birthDate,
  required String countryCode,
  required String maritalStatus,
  required String religion,
  required String profession,
  required String photo,
}) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseUrl}register'));
  request.fields.addAll({
    'username': userName,
    'email': email,
    'password': password,
    'mobile_code': '91',
    'mobile': mobileNo,
    'password_confirmation': passwordConfirmation,
    'country': country,
    'firstname': firstName,
    'lastname': lastName,
    'marital_status': maritalStatus,
    'looking_for': lookingFor,
    'gender': gender,
    'mother_tongue': motherTongue,
    'birth_date': birthDate,
    'country_code':countryCode,
    'religion': religion,
    'profession': profession,
    'agree': '1',
  });
  request.files.add(await http.MultipartFile.fromPath('image', photo));
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

