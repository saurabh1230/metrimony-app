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
  required String userType,
  required String community,
  required String positionHeld,
required String  state,
  required String  district,
required String cadar,
required String statePosting,
required String districtPosting,
required String postingStartDate,
required String  postingEndDate,
required String degree,
  required String  fieldofStudy,
  required String institute,
  required String  batchStart,
  required String batchEnd,
  // required String   phone,
  // required String age,


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
    'user_type':userType,
     "community" : community,
     // "age" : age,
    "position_held" : positionHeld,
     "state":   state,
    "district" : district,
     "cadar" : cadar,
     "state_posting"  : statePosting,
     "district_posting" :  districtPosting,
     "from_date" : postingStartDate,
     "till_date" :  postingEndDate,
     "degree" : degree,
     "field_of_study" :  fieldofStudy,
     "institute" : institute,

    "batch_start" :batchStart,
     "batch_end" :batchEnd,
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

// I/flutter (24198): {remark: registration_success, status: success, message: {success: [Registration successful]}, data: {access_token: 1465|mSo0Lff7ZHYJghsk35LeMN8KioKyH82Z5yTIVfqS, user: {profile_id: 52571296, looking_for: My Self, email: testuser@gmail.com, username: testuser, firstname: Test, lastname: Test, religion: 2, marital_status: unmarried, mother_tongue: 1, community: 1, profession: 7, middle_name: , gender: M, image: 6687da4d18a801720179277.jpg, country_code: IN, mobile: 919865986598, address: {address: null, state: Meghalaya, zip: null, country: India, district: null}, kv: 1, ev: 1, sv: 1, updated_at: 2024-07-05T11:34:37.000000Z, created_at: 2024-07-05T11:34:37.000000Z, id: 48}, token_type: Bearer}}