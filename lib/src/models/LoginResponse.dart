class LoginResponse {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  LoginResponse({this.remark, this.status, this.message, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    remark = json['remark'];
    status = json['status'];
    message =
    json['message'] != null ? new Message.fromJson(json['message']) : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['remark'] = this.remark;
    data['status'] = this.status;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Message {
  List<String>? success;

  Message({this.success});

  Message.fromJson(Map<String, dynamic> json) {
    success = json['success'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    return data;
  }
}

class Data {
  User? user;
  String? accessToken;
  String? tokenType;

  Data({this.user, this.accessToken, this.tokenType});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    return data;
  }
}

class User {
  int? id;
  int? profileId;
  String? firstname;
  String? lastname;
  int? lookingFor;
  String? username;
  String? gender;
  Address? address;
  String? email;
  String? countryCode;
  String? mobile;
  String? balance;
  int? status;
  int? profileComplete;
  int? totalStep;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? bloodGroup;
  String? religion;
  String? maritalStatus;
  String? motherTongue;
  String? community;

  User(
      {this.id,
        this.profileId,
        this.firstname,
        this.lastname,
        this.lookingFor,
        this.username,
        this.gender,
        this.address,
        this.email,
        this.countryCode,
        this.mobile,
        this.balance,
        this.status,
        this.profileComplete,
        this.totalStep,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.bloodGroup,
        this.religion,
        this.maritalStatus,
        this.motherTongue,
        this.community});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileId = json['profile_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    lookingFor = json['looking_for'];
    username = json['username'];
    gender = json['gender'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    email = json['email'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    balance = json['balance'];
    status = json['status'];
    profileComplete = json['profile_complete'];
    totalStep = json['total_step'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bloodGroup = json['blood_group'];
    religion = json['religion'];
    maritalStatus = json['marital_status'];
    motherTongue = json['mother_tongue'];
    community = json['community'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['profile_id'] = this.profileId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['gender'] = this.gender;
    data['looking_for'] = this.lookingFor;
    data['username'] = this.username;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['balance'] = this.balance;
    data['status'] = this.status;
    data['profile_complete'] = this.profileComplete;
    data['total_step'] = this.totalStep;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['blood_group'] = this.bloodGroup;
    data['religion'] = this.religion;
    data['marital_status'] = this.maritalStatus;
    data['mother_tongue'] = this.motherTongue;
    data['community'] = this.community;
    return data;
  }
}

class Address {
  String? address;
  String? state;
  String? zip;
  String? country;
  String? city;

  Address({this.address, this.state, this.zip, this.country, this.city});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    state = json['state'];
    zip = json['zip'];
    country = json['country'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['country'] = this.country;
    data['city'] = this.city;
    return data;
  }
}

// class LoginResponse {
//   LoginResponse({
//     required this.remark,
//     required this.status,
//     required this.message,
//     required this.data,
//   });
//   late final String remark;
//   late final String status;
//   late final Message message;
//   late final Data data;
//
//   LoginResponse.fromJson(Map<String, dynamic> json){
//     remark = json['remark'];
//     status = json['status'];
//     message = Message.fromJson(json['message']);
//     data = Data.fromJson(json['data']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['remark'] = remark;
//     _data['status'] = status;
//     _data['message'] = message.toJson();
//     _data['data'] = data.toJson();
//     return _data;
//   }
// }
//
// class Message {
//   Message({
//     required this.success,
//   });
//   late final List<String> success;
//
//   Message.fromJson(Map<String, dynamic> json){
//     success = List.castFrom<dynamic, String>(json['success']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['success'] = success;
//     return _data;
//   }
// }
//
// class Data {
//   Data({
//     required this.user,
//     required this.accessToken,
//     required this.tokenType,
//   });
//   late final User user;
//   late final String accessToken;
//   late final String tokenType;
//
//   Data.fromJson(Map<String, dynamic> json){
//     user = User.fromJson(json['user']);
//     accessToken = json['access_token'];
//     tokenType = json['token_type'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['user'] = user.toJson();
//     _data['access_token'] = accessToken;
//     _data['token_type'] = tokenType;
//     return _data;
//   }
// }
//
// class User {
//   User({
//     required this.id,
//     required this.profileId,
//     required this.firstname,
//     required this.lastname,
//     required this.lookingFor,
//     required this.username,
//     required this.address,
//     required this.email,
//     required this.countryCode,
//     required this.mobile,
//     required this.balance,
//     required this.status,
//     // this.kycData,
//     required this.kv,
//     required this.ev,
//     required this.sv,
//     required this.profileComplete,
//     // required this.skippedStep,
//     // required this.completedStep,
//     // required this.totalStep,
//     // this.verCodeSendAt,
//     // this.tsc,
//     // this.loginBy,
//     // this.banReason,
//     required this.image,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.bloodGroup,
//     required this.religion,
//     required this.maritalStatus,
//     required this.motherTongue,
//     required this.community,
//     required this.gender,
//   });
//   late final int id;
//   late final int profileId;
//   late final String? firstname;
//   late final String? lastname;
//   late final int lookingFor;
//   late final String username;
//   late final Address address;
//   late final String email;
//   late final String countryCode;
//   late final String mobile;
//   late final String balance;
//   late final int status;
//   // late final Null kycData;
//   late final int kv;
//   late final int ev;
//   late final int sv;
//   late final int profileComplete;
//   // late final List<dynamic> skippedStep;
//   // late final List<dynamic> completedStep;
//   // late final int totalStep;
//   // late final Null verCodeSendAt;
//   // late final Null tsc;
//   // late final Null loginBy;
//   // late final Null banReason;
//   late final String image;
//   late final String createdAt;
//   late final String updatedAt;
//   late final String bloodGroup;
//   late final String religion;
//   late final String maritalStatus;
//   late final String motherTongue;
//   late final String community;
//   late final String gender;
//
//   User.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     profileId = json['profile_id'];
//     firstname = json['firstname'];
//     lastname = json['lastname'];
//     lookingFor = json['looking_for'];
//     username = json['username'];
//     address = Address.fromJson(json['address']);
//     email = json['email'];
//     countryCode = json['country_code'];
//     mobile = json['mobile'];
//     balance = json['balance'];
//     status = json['status'];
//     // kycData = null;
//     kv = json['kv'];
//     ev = json['ev'];
//     sv = json['sv'];
//     profileComplete = json['profile_complete'];
//     // skippedStep = List.castFrom<dynamic, dynamic>(json['skipped_step']);
//     // completedStep = List.castFrom<dynamic, dynamic>(json['completed_step']);
//     // totalStep = json['total_step'];
//     // verCodeSendAt = null;
//     // tsc = null;
//     // loginBy = null;
//     // banReason = null;
//     image = json['image'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     bloodGroup = json['blood_group'];
//     religion = json['religion'];
//     maritalStatus = json['marital_status'];
//     motherTongue = json['mother_tongue'];
//     community = json['community'];
//     gender = json['gender'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['profile_id'] = profileId;
//     _data['firstname'] = firstname;
//     _data['lastname'] = lastname;
//     _data['looking_for'] = lookingFor;
//     _data['username'] = username;
//     _data['address'] = address.toJson();
//     _data['email'] = email;
//     _data['country_code'] = countryCode;
//     _data['mobile'] = mobile;
//     _data['balance'] = balance;
//     _data['status'] = status;
//     // _data['kyc_data'] = kycData;
//     _data['kv'] = kv;
//     _data['ev'] = ev;
//     _data['sv'] = sv;
//     _data['profile_complete'] = profileComplete;
//     // _data['skipped_step'] = skippedStep;
//     // _data['completed_step'] = completedStep;
//     // _data['total_step'] = totalStep;
//     // _data['ver_code_send_at'] = verCodeSendAt;
//     // _data['tsc'] = tsc;
//     // _data['login_by'] = loginBy;
//     // _data['ban_reason'] = banReason;
//     _data['image'] = image;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     _data['blood_group'] = bloodGroup;
//     _data['religion'] = religion;
//     _data['marital_status'] = maritalStatus;
//     _data['mother_tongue'] = motherTongue;
//     _data['community'] = community;
//     _data['gender'] = gender;
//     return _data;
//   }
// }
//
// class Address {
//   Address({
//     required this.address,
//     required this.state,
//     required this.zip,
//     required this.country,
//     required this.city,
//   });
//   late final String address;
//   late final String state;
//   late final String zip;
//   late final String country;
//   late final String city;
//
//   Address.fromJson(Map<String, dynamic> json){
//     address = json['address'];
//     state = json['state'];
//     zip = json['zip'];
//     country = json['country'];
//     city = json['city'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['address'] = address;
//     _data['state'] = state;
//     _data['zip'] = zip;
//     _data['country'] = country;
//     _data['city'] = city;
//     return _data;
//   }
// }