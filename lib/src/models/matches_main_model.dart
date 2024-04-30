class MatchesMainModel {
  int? currentPage;
  List<Data>? data;


  MatchesMainModel(
      {this.currentPage,
        this.data,
      });

  MatchesMainModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Data {
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
  String? kycData;
  int? kv;
  int? ev;
  int? sv;
  int? bookmark;
  int? profileComplete;
  int? totalStep;
  String? verCodeSendAt;
  String? tsc;
  String? loginBy;
  String? banReason;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? bloodGroup;
  String? religion;
  String? maritalStatus;
  String? motherTongue;
  String? community;
  // String? physicalAttributes;
  String? limitation;
  BasicInfo? basicInfo;
  PhysicalAttributes? physicalAttributes;



  Data({
    this.id,
    this.profileId,
    this.firstname,
    this.lastname,
    this.lookingFor,
    this.username,
    this.email,
    this.countryCode,
    this.mobile,
    this.balance,
    this.status,
    this.kycData,
    this.address,
    this.kv,
    this.ev,
    this.sv,
    this.bookmark,
    this.profileComplete,
    this.totalStep,
    this.verCodeSendAt,
    this.tsc,
    this.loginBy,
    this.banReason,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.bloodGroup,
    this.religion,
    this.maritalStatus,
    this.motherTongue,
    this.community,
    this.physicalAttributes,
    this.limitation,
    this.basicInfo,



  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileId = json['profile_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    lookingFor = json['lookingFor'];
    username = json['username'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    basicInfo = json['basic_info'] != null
        ? new BasicInfo.fromJson(json['basic_info'])
        : null;
    physicalAttributes = json['physical_attributes'] != null
        ? new PhysicalAttributes.fromJson(json['physical_attributes'])
        : null;



    email = json['email'];
    countryCode = json['countryCode'];
    mobile = json['mobile'];
    balance = json['balance'];
    status = json['status'];
    kycData = json['kycData']?.toString();
    kv = json['kv'];
    ev = json['ev'];
    sv = json['sv'];
    bookmark = json['bookmark'];
    profileComplete = json['profileComplete'];
    totalStep = json['totalStep'];
    verCodeSendAt = json['verCodeSendAt']?.toString();
    tsc = json['tsc']?.toString();
    loginBy = json['loginBy']?.toString();
    banReason = json['banReason']?.toString();
    image = json['image']?.toString();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    bloodGroup = json['bloodGroup'];
    religion = json['religion'];
    maritalStatus = json['maritalStatus'];
    motherTongue = json['motherTongue'];
    community = json['community'];



  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['profile_id'] = profileId;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['lookingFor'] = lookingFor;
    data['username'] = username;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.basicInfo != null) {
      data['basic_info'] = this.basicInfo!.toJson();
    }
    if (this.physicalAttributes != null) {
      data['physical_attributes'] = this.physicalAttributes!.toJson();
    }
    // data['address'] = address?.toJson();
    data['email'] = email;
    data['countryCode'] = countryCode;
    data['mobile'] = mobile;
    data['balance'] = balance;
    data['status'] = status;
    data['kycData'] = kycData;
    data['kv'] = kv;
    data['ev'] = ev;
    data['sv'] = sv;
    data['bookmark'] = bookmark;
    data['profileComplete'] = profileComplete;
    data['totalStep'] = totalStep;
    data['verCodeSendAt'] = verCodeSendAt;
    data['tsc'] = tsc;
    data['loginBy'] = loginBy;
    data['banReason'] = banReason;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['bloodGroup'] = bloodGroup;
    data['religion'] = religion;
    data['maritalStatus'] = maritalStatus;
    data['motherTongue'] = motherTongue;
    data['community'] = community;
    data['limitation'] = limitation;

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
  String? religion;
  int? smokingStatus;
  int? drinkingStatus;
  String? birthDate;
  String? maritalStatus;
  String? createdAt;
  String? updatedAt;
  String? community;
  String? motherTongue;
  PresentAddress? presentAddress;
  String? aboutUs;
  int? age;

  BasicInfo(
      {  this.id,
        this.userId,
        this.gender,
        this.profession,
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
    religion = json['religion'];
    smokingStatus = json['smoking_status'];
    drinkingStatus = json['drinking_status'];
    birthDate = json['birth_date'];
    maritalStatus = json['marital_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    community = json['community'];
    motherTongue = json['mother_tongue'];
    aboutUs = json['about_us'];
    age = json['age'];
    presentAddress = json['present_address'] != null
        ? new PresentAddress.fromJson(json['present_address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['gender'] = this.gender;
    data['profession'] = this.profession;
    data['religion'] = this.religion;
    data['smoking_status'] = this.smokingStatus;
    data['drinking_status'] = this.drinkingStatus;
    data['birth_date'] = this.birthDate;
    data['marital_status'] = this.maritalStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['community'] = this.community;
    data['mother_tongue'] = this.motherTongue;
    data['about_us'] = this.aboutUs;
    data['age'] = this.age;
    if (this.presentAddress != null) {
      data['present_address'] = this.presentAddress!.toJson();
    }
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

class Interests {
  int? id;
  int? userId;
  int? interestingId;
  int? status;
  String? createdAt;
  String? updatedAt;

  Interests(
      {this.id,
        this.userId,
        this.interestingId,
        this.status,
        this.createdAt,
        this.updatedAt});

  Interests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    interestingId = json['interesting_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['interesting_id'] = this.interestingId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class PhysicalAttributes {
  int? id;
  int? userId;
  String? height;
  String? weight;
  String? bloodGroup;
  String? eyeColor;
  String? hairColor;
  String? complexion;
  String? disability;
  String? createdAt;
  String? updatedAt;

  PhysicalAttributes(
      {this.id,
        this.userId,
        this.height,
        this.weight,
        this.bloodGroup,
        this.eyeColor,
        this.hairColor,
        this.complexion,
        this.disability,
        this.createdAt,
        this.updatedAt});

  PhysicalAttributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    height = json['height'];
    weight = json['weight'];
    bloodGroup = json['blood_group'];
    eyeColor = json['eye_color'];
    hairColor = json['hair_color'];
    complexion = json['complexion'];
    disability = json['disability'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['blood_group'] = this.bloodGroup;
    data['eye_color'] = this.eyeColor;
    data['hair_color'] = this.hairColor;
    data['complexion'] = this.complexion;
    data['disability'] = this.disability;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}