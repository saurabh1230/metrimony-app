class SavedMatchesModel {
  int? id;
  int? userId;
  int? profileId;

  Profile? profile;

  SavedMatchesModel(
      {this.id,
        this.userId,
        this.profileId,

        this.profile});

  SavedMatchesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    profileId = json['profile_id'];

    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['profile_id'] = this.profileId;

    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }
}

class Profile {
  int? id;
  int? profileId;
  String? firstname;
  String? lastname;

  String? username;

  String? email;
  String? countryCode;
  String? mobile;
  String? balance;
  int? status;
  int? kv;
  int? ev;
  int? sv;
  int? profileComplete;
  int? totalStep;
  String? image;

  String? bloodGroup;
  String? religion;
  String? maritalStatus;
  String? motherTongue;
  String? community;
  String? gender;
  BasicInfo? basicInfo;


  Profile(
      {this.id,
        this.profileId,
        this.firstname,
        this.lastname,

        this.username,

        this.email,
        this.countryCode,
        this.mobile,
        this.balance,
        this.status,

        this.kv,
        this.ev,
        this.sv,
        this.profileComplete,
        this.totalStep,
        this.image,

        this.bloodGroup,
        this.religion,
        this.maritalStatus,
        this.motherTongue,
        this.community,
        this.gender,
        this.basicInfo,
        });

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileId = json['profile_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    username = json['username'];
    email = json['email'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    balance = json['balance'];
    status = json['status'];
    kv = json['kv'];
    ev = json['ev'];
    sv = json['sv'];
    profileComplete = json['profile_complete'];
    totalStep = json['total_step'];
    image = json['image'];
    bloodGroup = json['blood_group'];
    religion = json['religion'];
    maritalStatus = json['marital_status'];
    motherTongue = json['mother_tongue'];
    community = json['community'];
    gender = json['gender'];
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
    data['username'] = this.username;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['balance'] = this.balance;
    data['status'] = this.status;
    data['kv'] = this.kv;
    data['ev'] = this.ev;
    data['sv'] = this.sv;
    data['profile_complete'] = this.profileComplete;
    data['total_step'] = this.totalStep;
    data['image'] = this.image;
    data['blood_group'] = this.bloodGroup;
    data['religion'] = this.religion;
    data['marital_status'] = this.maritalStatus;
    data['mother_tongue'] = this.motherTongue;
    data['community'] = this.community;
    data['gender'] = this.gender;
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
  String? financialCondition;
  String? religion;
  int? smokingStatus;
  int? drinkingStatus;
  String? birthDate;
  String? maritalStatus;
  PresentAddress? presentAddress;
  String? createdAt;
  String? updatedAt;
  String? community;
  String? motherTongue;
  String? aboutUs;
  int? age;

  BasicInfo(
      {this.id,
        this.userId,
        this.gender,
        this.profession,
        this.financialCondition,
        this.religion,
        this.smokingStatus,
        this.drinkingStatus,
        this.birthDate,
        this.maritalStatus,
        this.presentAddress,

        this.createdAt,
        this.updatedAt,
        this.community,
        this.motherTongue,
        this.aboutUs,
        this.age});

  BasicInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    gender = json['gender'];
    profession = json['profession'];
    financialCondition = json['financial_condition'];
    religion = json['religion'];
    smokingStatus = json['smoking_status'];
    drinkingStatus = json['drinking_status'];
    birthDate = json['birth_date'];
    maritalStatus = json['marital_status'];
    presentAddress = json['present_address'] != null
        ? new PresentAddress.fromJson(json['present_address'])
        : null;

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    community = json['community'];
    motherTongue = json['mother_tongue'];
    aboutUs = json['about_us'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['gender'] = this.gender;
    data['profession'] = this.profession;
    data['financial_condition'] = this.financialCondition;
    data['religion'] = this.religion;
    data['smoking_status'] = this.smokingStatus;
    data['drinking_status'] = this.drinkingStatus;
    data['birth_date'] = this.birthDate;
    data['marital_status'] = this.maritalStatus;
    if (this.presentAddress != null) {
      data['present_address'] = this.presentAddress!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['community'] = this.community;
    data['mother_tongue'] = this.motherTongue;
    data['about_us'] = this.aboutUs;
    data['age'] = this.age;
    return data;
  }
}

class PresentAddress {
  String? country;
  String? state;
  String? zip;
  String? city;

  PresentAddress({this.country, this.state, this.zip, this.city});

  PresentAddress.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    state = json['state'];
    zip = json['zip'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['city'] = this.city;
    return data;
  }
}


