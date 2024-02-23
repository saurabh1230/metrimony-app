class ConnectionRequestModel {
  int? id;
  int? userId;
  int? interestingId;
  int? status;
  String? createdAt;
  String? updatedAt;
  User? user;
  // Null? conversation;

  ConnectionRequestModel(
      {this.id,
        this.userId,
        this.interestingId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.user,
        // this.conversation
      });

  ConnectionRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    interestingId = json['interesting_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    // conversation = json['conversation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['interesting_id'] = this.interestingId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    // data['conversation'] = this.conversation;
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
  // Null? kycData;
  int? kv;
  int? ev;
  int? sv;
  int? profileComplete;
  // List<Null>? skippedStep;
  // List<Null>? completedStep;
  // int? totalStep;
  // Null? verCodeSendAt;
  // Null? tsc;
  // Null? loginBy;
  // Null? banReason;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? bloodGroup;
  String? religion;
  String? maritalStatus;
  String? motherTongue;
  String? community;
  BasicInfo? basicInfo;

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
        // this.kycData,
        this.kv,
        this.ev,
        this.sv,
        this.profileComplete,
        // this.skippedStep,
        // this.completedStep,
        // this.totalStep,
        // this.verCodeSendAt,
        // this.tsc,
        // this.loginBy,
        // this.banReason,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.bloodGroup,
        this.religion,
        this.maritalStatus,
        this.motherTongue,
        this.community,
        this.basicInfo});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileId = json['profile_id'];
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
    // kycData = json['kyc_data'];
    kv = json['kv'];
    ev = json['ev'];
    sv = json['sv'];
    profileComplete = json['profile_complete'];
    // if (json['skipped_step'] != null) {
    //   skippedStep = <Null>[];
    //   json['skipped_step'].forEach((v) {
    //     skippedStep!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['completed_step'] != null) {
    //   completedStep = <Null>[];
    //   json['completed_step'].forEach((v) {
    //     completedStep!.add(new Null.fromJson(v));
    //   });
    // }
    // totalStep = json['total_step'];
    // verCodeSendAt = json['ver_code_send_at'];
    // tsc = json['tsc'];
    // loginBy = json['login_by'];
    // banReason = json['ban_reason'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bloodGroup = json['blood_group'];
    religion = json['religion'];
    maritalStatus = json['marital_status'];
    motherTongue = json['mother_tongue'];
    community = json['community'];
    basicInfo = json['basic_info'] != null
        ? new BasicInfo.fromJson(json['basic_info'])
        : null;
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
    // data['kyc_data'] = this.kycData;
    data['kv'] = this.kv;
    data['ev'] = this.ev;
    data['sv'] = this.sv;
    data['profile_complete'] = this.profileComplete;
    // if (this.skippedStep != null) {
    //   data['skipped_step'] = this.skippedStep!.map((v) => v.toJson()).toList();
    // }
    // if (this.completedStep != null) {
    //   data['completed_step'] =
    //       this.completedStep!.map((v) => v.toJson()).toList();
    // }
    // data['total_step'] = this.totalStep;
    // data['ver_code_send_at'] = this.verCodeSendAt;
    // data['tsc'] = this.tsc;
    // data['login_by'] = this.loginBy;
    // data['ban_reason'] = this.banReason;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['blood_group'] = this.bloodGroup;
    data['religion'] = this.religion;
    data['marital_status'] = this.maritalStatus;
    data['mother_tongue'] = this.motherTongue;
    data['community'] = this.community;
    if (this.basicInfo != null) {
      data['basic_info'] = this.basicInfo!.toJson();
    }
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

class BasicInfo {
  int? id;
  int? userId;
  String? gender;
  String? profession;
  // Null? financialCondition;
  String? religion;
  int? smokingStatus;
  int? drinkingStatus;
  String? birthDate;
  // List<Null>? language;
  String? maritalStatus;
  // Null? presentAddress;
  // Null? permanentAddress;
  String? createdAt;
  String? updatedAt;
  String? community;
  String? motherTongue;

  BasicInfo(
      {this.id,
        this.userId,
        this.gender,
        this.profession,
        // this.financialCondition,
        this.religion,
        this.smokingStatus,
        this.drinkingStatus,
        this.birthDate,
        // this.language,
        this.maritalStatus,
        // this.presentAddress,
        // this.permanentAddress,
        this.createdAt,
        this.updatedAt,
        this.community,
        this.motherTongue});

  BasicInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    gender = json['gender'];
    profession = json['profession'];
    // financialCondition = json['financial_condition'];
    religion = json['religion'];
    smokingStatus = json['smoking_status'];
    drinkingStatus = json['drinking_status'];
    birthDate = json['birth_date'];
    // if (json['language'] != null) {
    //   language = <Null>[];
    //   json['language'].forEach((v) {
    //     language!.add(new Null.fromJson(v));
    //   });
    // }
    maritalStatus = json['marital_status'];
    // presentAddress = json['present_address'];
    // permanentAddress = json['permanent_address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    community = json['community'];
    motherTongue = json['mother_tongue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['gender'] = this.gender;
    data['profession'] = this.profession;
    // data['financial_condition'] = this.financialCondition;
    data['religion'] = this.religion;
    data['smoking_status'] = this.smokingStatus;
    data['drinking_status'] = this.drinkingStatus;
    data['birth_date'] = this.birthDate;
    // if (this.language != null) {
    //   data['language'] = this.language!.map((v) => v.toJson()).toList();
    // }
    data['marital_status'] = this.maritalStatus;
    // data['present_address'] = this.presentAddress;
    // data['permanent_address'] = this.permanentAddress;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['community'] = this.community;
    data['mother_tongue'] = this.motherTongue;
    return data;
  }
}
