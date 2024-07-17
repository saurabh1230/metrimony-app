class MatchesModel {
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
  String? image;
  String? createdAt;
  String? updatedAt;
  String? bloodGroup;
  Religion? religion;
  String? maritalStatus;
  Religion? motherTongue;
  Religion? community;
  String? gender;
  Religion? profession;
  String? middleName;
  int? bookmark;
  int? interestStatus;
  BasicInfo? basicInfo;
  String? bloodGroups;
  String? maritialStatus;
  List<CareerInfo>? careerInfo;
  PartnerExpectation? partnerExpectation;
  PhysicalAttributes? physicalAttributes;
  List<EducationInfo>? educationInfo;
  List<Interests>? interests;

  MatchesModel(
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
        this.image,
        this.createdAt,
        this.updatedAt,
        this.bloodGroup,
        this.religion,
        this.maritalStatus,
        this.motherTongue,
        this.community,
        this.gender,
        this.profession,
        this.middleName,
        this.bookmark,
        this.interestStatus,
        this.basicInfo,
        this.bloodGroups,
        this.maritialStatus,
        this.careerInfo,
        this.partnerExpectation,
        this.physicalAttributes,
        this.educationInfo,
        this.interests});

  MatchesModel.fromJson(Map<String, dynamic> json) {
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
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bloodGroup = json['blood_group'];
    religion = json['religion'] != null
        ? new Religion.fromJson(json['religion'])
        : null;
    maritalStatus = json['marital_status'];
    motherTongue = json['mother_tongue'] != null
        ? new Religion.fromJson(json['mother_tongue'])
        : null;
    community = json['community'] != null
        ? new Religion.fromJson(json['community'])
        : null;
    gender = json['gender'];
    profession = json['profession'] != null
        ? new Religion.fromJson(json['profession'])
        : null;
    middleName = json['middle_name'];
    bookmark = json['bookmark'];
    interestStatus = json['interestStatus'];
    basicInfo = json['basic_info'] != null
        ? new BasicInfo.fromJson(json['basic_info'])
        : null;
    bloodGroups = json['blood_groups'];
    maritialStatus = json['maritial_status'];
    if (json['career_info'] != null) {
      careerInfo = <CareerInfo>[];
      json['career_info'].forEach((v) {
        careerInfo!.add(new CareerInfo.fromJson(v));
      });
    }
    partnerExpectation = json['partner_expectation'] != null
        ? new PartnerExpectation.fromJson(json['partner_expectation'])
        : null;
    physicalAttributes = json['physical_attributes'] != null
        ? new PhysicalAttributes.fromJson(json['physical_attributes'])
        : null;
    if (json['education_info'] != null) {
      educationInfo = <EducationInfo>[];
      json['education_info'].forEach((v) {
        educationInfo!.add(new EducationInfo.fromJson(v));
      });
    }
    if (json['interests'] != null) {
      interests = <Interests>[];
      json['interests'].forEach((v) {
        interests!.add(new Interests.fromJson(v));
      });
    }
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
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['blood_group'] = this.bloodGroup;
    if (this.religion != null) {
      data['religion'] = this.religion!.toJson();
    }
    data['marital_status'] = this.maritalStatus;
    if (this.motherTongue != null) {
      data['mother_tongue'] = this.motherTongue!.toJson();
    }
    if (this.community != null) {
      data['community'] = this.community!.toJson();
    }
    data['gender'] = this.gender;
    if (this.profession != null) {
      data['profession'] = this.profession!.toJson();
    }
    data['middle_name'] = this.middleName;
    data['bookmark'] = this.bookmark;
    data['interestStatus'] = this.interestStatus;
    if (this.basicInfo != null) {
      data['basic_info'] = this.basicInfo!.toJson();
    }
    data['blood_groups'] = this.bloodGroups;
    data['maritial_status'] = this.maritialStatus;
    if (this.careerInfo != null) {
      data['career_info'] = this.careerInfo!.map((v) => v.toJson()).toList();
    }
    if (this.partnerExpectation != null) {
      data['partner_expectation'] = this.partnerExpectation!.toJson();
    }
    if (this.physicalAttributes != null) {
      data['physical_attributes'] = this.physicalAttributes!.toJson();
    }
    if (this.educationInfo != null) {
      data['education_info'] =
          this.educationInfo!.map((v) => v.toJson()).toList();
    }
    if (this.interests != null) {
      data['interests'] = this.interests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  String? address;
  String? state;
  String? zip;
  String? country;
  String? district;

  Address({this.address, this.state, this.zip, this.country, this.district});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    state = json['state'];
    zip = json['zip'];
    country = json['country'];
    district = json['district'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['country'] = this.country;
    data['district'] = this.district;
    return data;
  }
}

class Religion {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Religion({this.id, this.name, this.createdAt, this.updatedAt});

  Religion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class BasicInfo {
  int? id;
  int? userId;
  int? userType;
  String? gender;
  Religion? profession;
  String? financialCondition;
  Religion? religion;
  int? smokingStatus;
  int? drinkingStatus;
  String? birthDate;
  String? maritalStatus;
  PresentAddress? presentAddress;
  PermanentAddress? permanentAddress;
  String? createdAt;
  String? updatedAt;
  Religion? community;
  Religion? motherTongue;
  String? aboutUs;
  int? age;
  String? batchStart;
  String? cadar;
  String? batchEnd;
  String? maritialStatus;
  Religion? drinking;
  Religion? smoking;

  BasicInfo(
      {this.id,
        this.userId,
        this.userType,
        this.gender,
        this.profession,
        this.financialCondition,
        this.religion,
        this.smokingStatus,
        this.drinkingStatus,
        this.birthDate,
        this.maritalStatus,
        this.presentAddress,
        this.permanentAddress,
        this.createdAt,
        this.updatedAt,
        this.community,
        this.motherTongue,
        this.aboutUs,
        this.age,
        this.batchStart,
        this.cadar,
        this.batchEnd,
        this.maritialStatus,
        this.drinking,
        this.smoking});

  BasicInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userType = json['user_type'];
    gender = json['gender'];
    profession = json['profession'] != null
        ? new Religion.fromJson(json['profession'])
        : null;
    financialCondition = json['financial_condition'];
    religion = json['religion'] != null
        ? new Religion.fromJson(json['religion'])
        : null;
    smokingStatus = json['smoking_status'];
    drinkingStatus = json['drinking_status'];
    birthDate = json['birth_date'];
    maritalStatus = json['marital_status'];
    presentAddress = json['present_address'] != null
        ? new PresentAddress.fromJson(json['present_address'])
        : null;
    permanentAddress = json['permanent_address'] != null
        ? new PermanentAddress.fromJson(json['permanent_address'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    community = json['community'] != null
        ? new Religion.fromJson(json['community'])
        : null;
    motherTongue = json['mother_tongue'] != null
        ? new Religion.fromJson(json['mother_tongue'])
        : null;
    aboutUs = json['about_us'];
    age = json['age'];
    batchStart = json['batch_start'];
    cadar = json['cadar'];
    batchEnd = json['batch_end'];
    maritialStatus = json['maritial_status'];
    drinking = json['drinking'] != null
        ? new Religion.fromJson(json['drinking'])
        : null;
    smoking =
    json['smoking'] != null ? new Religion.fromJson(json['smoking']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_type'] = this.userType;
    data['gender'] = this.gender;
    if (this.profession != null) {
      data['profession'] = this.profession!.toJson();
    }
    data['financial_condition'] = this.financialCondition;
    if (this.religion != null) {
      data['religion'] = this.religion!.toJson();
    }
    data['smoking_status'] = this.smokingStatus;
    data['drinking_status'] = this.drinkingStatus;
    data['birth_date'] = this.birthDate;
    data['marital_status'] = this.maritalStatus;
    if (this.presentAddress != null) {
      data['present_address'] = this.presentAddress!.toJson();
    }
    if (this.permanentAddress != null) {
      data['permanent_address'] = this.permanentAddress!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.community != null) {
      data['community'] = this.community!.toJson();
    }
    if (this.motherTongue != null) {
      data['mother_tongue'] = this.motherTongue!.toJson();
    }
    data['about_us'] = this.aboutUs;
    data['age'] = this.age;
    data['batch_start'] = this.batchStart;
    data['cadar'] = this.cadar;
    data['batch_end'] = this.batchEnd;
    data['maritial_status'] = this.maritialStatus;
    if (this.drinking != null) {
      data['drinking'] = this.drinking!.toJson();
    }
    if (this.smoking != null) {
      data['smoking'] = this.smoking!.toJson();
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

class PermanentAddress {
  String? country;
  String? state;
  String? zip;
  String? city;

  PermanentAddress({this.country, this.state, this.zip, this.city});

  PermanentAddress.fromJson(Map<String, dynamic> json) {
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

class CareerInfo {
  int? id;
  int? userId;
  int? position;
  String? from;
  String? end;
  String? createdAt;
  String? updatedAt;
  String? statePosting;
  String? districtPosting;
  Religion? positionHeld;

  CareerInfo(
      {this.id,
        this.userId,
        this.position,
        this.from,
        this.end,
        this.createdAt,
        this.updatedAt,
        this.statePosting,
        this.districtPosting,
        this.positionHeld});

  CareerInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    position = json['position'];
    from = json['from'];
    end = json['end'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    statePosting = json['state_posting'];
    districtPosting = json['district_posting'];
    positionHeld = json['position_held'] != null
        ? new Religion.fromJson(json['position_held'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['position'] = this.position;
    data['from'] = this.from;
    data['end'] = this.end;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['state_posting'] = this.statePosting;
    data['district_posting'] = this.districtPosting;
    if (this.positionHeld != null) {
      data['position_held'] = this.positionHeld!.toJson();
    }
    return data;
  }
}

class PartnerExpectation {
  int? id;
  int? userId;
  String? generalRequirement;
  String? country;
  int? minAge;
  int? maxAge;
  String? minHeight;
  String? maxHeight;
  String? maxWeight;
  String? maritalStatus;
  Religion? religion;
  String? complexion;
  int? smokingStatus;
  int? drinkingStatus;
  String? minDegree;
  Religion? profession;
  String? financialCondition;
  String? createdAt;
  String? updatedAt;
  Religion? motherTongue;
  Religion? community;
  int? position;
  String? maritialStatus;
  Religion? positionHeld;

  PartnerExpectation(
      {this.id,
        this.userId,
        this.generalRequirement,
        this.country,
        this.minAge,
        this.maxAge,
        this.minHeight,
        this.maxHeight,
        this.maxWeight,
        this.maritalStatus,
        this.religion,
        this.complexion,
        this.smokingStatus,
        this.drinkingStatus,
        this.minDegree,
        this.profession,
        this.financialCondition,
        this.createdAt,
        this.updatedAt,
        this.motherTongue,
        this.community,
        this.position,
        this.maritialStatus,
        this.positionHeld});

  PartnerExpectation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    generalRequirement = json['general_requirement'];
    country = json['country'];
    minAge = json['min_age'];
    maxAge = json['max_age'];
    minHeight = json['min_height'];
    maxHeight = json['max_height'];
    maxWeight = json['max_weight'];
    maritalStatus = json['marital_status'];
    religion = json['religion'] != null
        ? new Religion.fromJson(json['religion'])
        : null;
    complexion = json['complexion'];
    smokingStatus = json['smoking_status'];
    drinkingStatus = json['drinking_status'];
    minDegree = json['min_degree'];
    profession = json['profession'] != null
        ? new Religion.fromJson(json['profession'])
        : null;
    financialCondition = json['financial_condition'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    motherTongue = json['mother_tongue'] != null
        ? new Religion.fromJson(json['mother_tongue'])
        : null;
    community = json['community'] != null
        ? new Religion.fromJson(json['community'])
        : null;
    position = json['position'];
    maritialStatus = json['maritial_status'];
    positionHeld = json['position_held'] != null
        ? new Religion.fromJson(json['position_held'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['general_requirement'] = this.generalRequirement;
    data['country'] = this.country;
    data['min_age'] = this.minAge;
    data['max_age'] = this.maxAge;
    data['min_height'] = this.minHeight;
    data['max_height'] = this.maxHeight;
    data['max_weight'] = this.maxWeight;
    data['marital_status'] = this.maritalStatus;
    if (this.religion != null) {
      data['religion'] = this.religion!.toJson();
    }
    data['complexion'] = this.complexion;
    data['smoking_status'] = this.smokingStatus;
    data['drinking_status'] = this.drinkingStatus;

    data['min_degree'] = this.minDegree;
    if (this.profession != null) {
      data['profession'] = this.profession!.toJson();
    }
    data['financial_condition'] = this.financialCondition;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.motherTongue != null) {
      data['mother_tongue'] = this.motherTongue!.toJson();
    }
    if (this.community != null) {
      data['community'] = this.community!.toJson();
    }
    data['position'] = this.position;
    data['maritial_status'] = this.maritialStatus;
    if (this.positionHeld != null) {
      data['position_held'] = this.positionHeld!.toJson();
    }
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

class EducationInfo {
  int? id;
  int? userId;
  String? degree;
  String? fieldOfStudy;
  String? institute;
  int? regNo;
  int? rollNo;
  String? outOf;
  String? result;
  Null? start;
  Null? end;
  String? createdAt;
  String? updatedAt;

  EducationInfo(
      {this.id,
        this.userId,
        this.degree,
        this.fieldOfStudy,
        this.institute,
        this.regNo,
        this.rollNo,
        this.outOf,
        this.result,
        this.start,
        this.end,
        this.createdAt,
        this.updatedAt});

  EducationInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    degree = json['degree'];
    fieldOfStudy = json['field_of_study'];
    institute = json['institute'];
    regNo = json['reg_no'];
    rollNo = json['roll_no'];
    outOf = json['out_of'];
    result = json['result'];
    start = json['start'];
    end = json['end'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['degree'] = this.degree;
    data['field_of_study'] = this.fieldOfStudy;
    data['institute'] = this.institute;
    data['reg_no'] = this.regNo;
    data['roll_no'] = this.rollNo;
    data['out_of'] = this.outOf;
    data['result'] = this.result;
    data['start'] = this.start;
    data['end'] = this.end;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
