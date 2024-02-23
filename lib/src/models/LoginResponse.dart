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
    profileId = json['profile_id'].int;
    firstname = json['firstname'];
    lastname = json['lastname'];
    lookingFor = json['looking_for'];
    username = json['username'];
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
