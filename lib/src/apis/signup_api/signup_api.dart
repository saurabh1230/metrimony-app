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
  required String middleName,
  required String lookingFor,
  required String gender,
  required String motherTongue,
  required String birthDate,
  required String countryCode,
  required String maritalStatus,
  required String religion,
  required String profession,
  required String userType,
  required String community,
  required String positionHeld,
  required String state,
  required String district,
  required String cadar,
  required String statePosting,
  required String districtPosting,
  required String postingStartDate,
  required String postingEndDate,
  required String degree,
  required String fieldofStudy,
  required String institute,
  required String batchStart,
  required String batchEnd,

  required String maritalStatusP,
  required String religionP,
  required String communityP,
  required String motherTongueP,
  required String professionP,
  required String positionP,
  required String countryP,
required String minAgeP,
required String maxAgeP,
required String minHeightP,
required String maxHeightP,
required String smokingP,
required String drinkingP,
  // required String   phone,
  // required String age,

  required String photo,
}) async {
  var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}register'));
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
    'middle_name' :middleName,
    'marital_status': maritalStatus,
    'looking_for': lookingFor,
    'gender': gender,
    'mother_tongue': motherTongue,
    'birth_date': birthDate,
    'country_code': countryCode,
    'religion': religion,
    'profession': profession,
    'user_type': userType,
    "community": community,
    // "age" : age,
    "position": positionHeld,
    "state": state,
    "district": district,
    "cadar": cadar,
    "state_posting": statePosting,
    "district_posting": districtPosting,
    "from_date": postingStartDate,
    "till_date": postingEndDate,
    "degree": degree,
    "field_of_study": fieldofStudy,
    "institute": institute,
    "batch_start": batchStart,
    "batch_end": batchEnd,

    'marital_status_p' :maritalStatusP,
    'religion_p' : religionP,
    'community_p' : communityP,
      'mother_tongue_p' : motherTongueP,
      'profession_p' : professionP,
      'position_p': positionP,
      'country_p': 'India',
       'min_age_p' : minAgeP,
      'max_age_p':maxAgeP,
      'min_height_p': minHeightP,
       'max_height_p' : maxHeightP,
      'smoking_status ' :smokingP,
      'drinking_status ' : drinkingP,
    // "phone" :  phone,
    'agree': '1',
  });
  request.files.add(await http.MultipartFile.fromPath('image', photo));

  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  print(resp);
  print(request.fields);
  if (response.statusCode == 200) {
    return resp;
  } else {
    print(resp);
    print(response.reasonPhrase);
    print(response.statusCode);
    return resp;
  }
}

